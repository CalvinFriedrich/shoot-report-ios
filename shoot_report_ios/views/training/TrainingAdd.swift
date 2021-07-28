import Introspect
import SwiftUI
import PhotosUI
import AlertToast

struct TrainingAdd: View {
    private class TextFieldObserver: NSObject {
        @objc
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.selectAll(nil)
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingAlert = false
    @State private var showingSuccessAlert = false
    @State var isImagePickerViewPresented = false
    @State var moodEmote: HelperMood.Mood = HelperMood.Mood.fine
    @State var trainingKind: HelperTrainingKind.Kind = HelperTrainingKind.Kind.setUp
    @State var location: String = ""
    @State var date: Date = Date()
    @State var pickedImages: [UIImage] = []
    @State var shoot_count: String = ""
    @State var shots: [String] = []
    @State var totalRings: Double = 0
    @State var average: Double = 0
    @State var report: String = ""
    
    private let textFieldObserver = TextFieldObserver()
    var rifle: Rifle
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(LocalizedStringKey("training_add_title_mood"))) {
                    Picker(LocalizedStringKey("training_add_title_mood"), selection: $moodEmote) {
                        ForEach(HelperMood.Mood.allCases) { mood in
                            Text(mood.rawValue).tag(mood)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text(LocalizedStringKey("training_add_title_general"))) {
                    Picker(LocalizedStringKey("training_add_kind"), selection: $trainingKind) {
                        ForEach(HelperTrainingKind.Kind.allCases) { kind in
                            Text(LocalizedStringKey(kind.rawValue)).tag(kind)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    TextField(LocalizedStringKey("training_add_location"), text: $location)
                    DatePicker(LocalizedStringKey("training_add_date"), selection: $date, displayedComponents: [.date])
                }
                
                Section {
                    if pickedImages.count > 0 {
                        HStack {
                            Spacer()
                            Image(uiImage: pickedImages[0])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                        }
                        Button(action: { self.pickedImages = [] }, label: {
                            HStack {
                                Spacer()
                                Text(LocalizedStringKey("training_add_deletephoto"))
                                    .bold()
                                Spacer()
                            }
                        })
                    }
                    Button(action: { self.isImagePickerViewPresented = true }, label: {
                        HStack {
                            Spacer()
                            Text(LocalizedStringKey("training_add_photo"))
                                .bold()
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                    })
                    .listRowBackground(Color("mainColor"))
                    Button(action: { self.showingAlert.toggle() }, label: {
                        HStack {
                            Spacer()
                            Text(LocalizedStringKey("training_add_qrcode"))
                                .bold()
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                    })
                    .listRowBackground(Color("mainColor"))
                }
                
                Section(header: Text(LocalizedStringKey("training_add_title_shots"))) {
                    TextField(LocalizedStringKey("training_add_shootcount"), text: $shoot_count)
                        .keyboardType(.numberPad)
                        .introspectTextField { textField in
                            textField.addTarget(
                                textFieldObserver,
                                action: #selector(TextFieldObserver.textFieldDidBeginEditing),
                                for: .editingDidBegin
                            )
                        }
                    ForEach(0..<Int(floor(Double(shots.count) / 3.0)), id: \.self) { i in
                        HStack {
                            ForEach(0...2, id: \.self) { n in
                                let help: Int = 3 * i
                                let num: Int = help + n
                                TextField(LocalizedStringKey("training_add_shot \(3 * i + n + 1)"), text: Binding(
                                            get: { shots[num] },
                                            set: { shots[num] = $0.replacingOccurrences(of: ",", with: ".") }))
                                    .keyboardType(.decimalPad)
                                    .introspectTextField { textField in
                                        textField.addTarget(
                                            textFieldObserver,
                                            action: #selector(TextFieldObserver.textFieldDidBeginEditing),
                                            for: .editingDidBegin
                                        )
                                    }
                            }
                        }
                    }
                    if (shots.count % 3 != 0) {
                        HStack {
                            ForEach(0..<shots.count % 3, id: \.self) { n in
                                let num: Int = shots.count - shots.count % 3 + n
                                TextField(LocalizedStringKey("training_add_shot \(num + 1)"), text: Binding(
                                            get: { shots[num] },
                                            set: { shots[num] = $0.replacingOccurrences(of: ",", with: ".") }))
                                    .keyboardType(.decimalPad)
                                    .introspectTextField { textField in
                                        textField.addTarget(
                                            textFieldObserver,
                                            action: #selector(TextFieldObserver.textFieldDidBeginEditing),
                                            for: .editingDidBegin
                                        )
                                    }
                            }
                        }
                    }
                }.onChange(of: shoot_count, perform: { value in
                    if (Double(value) != nil) {
                        shots = Array(repeating: "", count: Int(ceil(Double(value)! / 10.0)))
                    } else {
                        shots = []
                    }
                })
                
                Section(header: Text(LocalizedStringKey("training_add_title_info"))) {
                    HStack {
                        Text(LocalizedStringKey("training_add_total"))
                        Spacer()
                        Text("\(totalRings, specifier: "%.1f")")
                            .onChange(of: shots, perform: { value in
                                result()
                            })
                    }
                    HStack {
                        Text(LocalizedStringKey("training_add_average"))
                        Spacer()
                        Text("\(average, specifier: "%.2f")")
                            .onChange(of: shoot_count, perform: { value in
                                result()
                            })
                    }
                }
                
                Section(header: Text(LocalizedStringKey("training_add_title_report"))) {
                    TextEditor(text: $report)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                        .ignoresSafeArea(.keyboard)
                }
                
                Section {
                    Button(action: { addTraining() }, label: {
                        HStack {
                            Spacer()
                            Text(LocalizedStringKey("training_add_save"))
                                .bold()
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                    })
                    .listRowBackground(Color("mainColor"))
                }
            }
            .onAppear(perform: {
                self.location = UserDefaults.standard.string(forKey: "user_club_1") ?? ""
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(LocalizedStringKey("general_soon_title")), message: Text(LocalizedStringKey("general_soon_text")), dismissButton: .default(Text(LocalizedStringKey("general_soon_button"))))
            }
            .toast(isPresenting: $showingSuccessAlert, duration: 3, tapToDismiss: false, alert: {
                AlertToast(type: .complete(Color("accentColor")), title: NSLocalizedString("training_add_success", comment: ""))
            }, completion: {
                presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitle(LocalizedStringKey("training_add"))
            .navigationBarItems(
                trailing:
                    HStack {
                        Button(LocalizedStringKey("general_close"), action: {
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
            )
            .sheet(isPresented: $isImagePickerViewPresented) {
                PhotoPicker(pickerResult: $pickedImages, isPresented: $isImagePickerViewPresented)
            }
        }
    }
    
    private func addTraining() {
        withAnimation {
            let newTraining = Training(context: viewContext)
            newTraining.training = trainingKind.rawValue
            newTraining.date = date
            if (pickedImages.count) > 0 {
                newTraining.image = pickedImages[0].jpegData(compressionQuality: 1)
            } else {
                newTraining.image = nil
            }
            newTraining.indicator = moodEmote.rawValue
            newTraining.place = location
            newTraining.report = report
            newTraining.rifleId = rifle.id
            newTraining.shoot_count = Int16(shoot_count) ?? 0
            newTraining.shoots = shots.compactMap(Double.init)
            
            do {
                try viewContext.save()
                showingSuccessAlert.toggle()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func result() {
        let doubles = shots.compactMap(Double.init)
        let shootCount = Int(shoot_count) ?? 0
        self.totalRings = doubles.reduce(0, +)
        
        if (shootCount != 0) {
            self.average = totalRings / Double(shootCount)
        }
    }
}

struct TrainingAdd_Previews: PreviewProvider {
    static var previews: some View {
        TrainingAdd(rifle: Rifle())
    }
}
