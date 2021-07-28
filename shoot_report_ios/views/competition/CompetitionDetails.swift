import SwiftUI
import PhotosUI
import AlertToast

struct CompetitionDetails: View {
    
    private class TextFieldObserver: NSObject {
        @objc
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.selectAll(nil)
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingAlert = false
    @State var isImagePickerViewPresented = false
    @State private var showingSuccessAlert = false
    @State var inEdit: Bool = true
    @State var competitionKind: HelperCompetitionKind.Kind = HelperCompetitionKind.Kind.league
    @State var location: String = ""
    @State var date: Date = Date()
    @State var pickedImages: [UIImage] = []
    @State var shoot_count: String = ""
    @State var shots: [String] = []
    @State var totalRings: Double = 0
    @State var report: String = ""
    
    private let textFieldObserver = TextFieldObserver()
    
    @Binding var competition: Competition
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(LocalizedStringKey("competition_add_title_general"))) {
                    Picker(LocalizedStringKey("competition_add_kind"), selection: $competitionKind) {
                        ForEach(HelperCompetitionKind.Kind.allCases) { kind in
                            Text(LocalizedStringKey(kind.rawValue)).tag(kind)
                        }
                    }
                    .disabled(inEdit)
                    .pickerStyle(MenuPickerStyle())
                    TextField(LocalizedStringKey("competition_add_location"), text: $location)
                        .disabled(inEdit)
                    DatePicker(LocalizedStringKey("competition_add_date"), selection: $date, displayedComponents: [.date])
                        .disabled(inEdit)
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
                                Text(LocalizedStringKey("competition_add_deletephoto"))
                                    .bold()
                                Spacer()
                            }
                        })
                        .disabled(inEdit)
                    }
                    Button(action: { self.isImagePickerViewPresented = true }, label: {
                        HStack {
                            Spacer()
                            Text(LocalizedStringKey("competition_add_photo"))
                                .bold()
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                    })
                    .listRowBackground(Color("mainColor"))
                    .disabled(inEdit)
                    Button(action: { self.showingAlert.toggle() }, label: {
                        HStack {
                            Spacer()
                            Text(LocalizedStringKey("competition_add_qrcode"))
                                .bold()
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                    })
                    .listRowBackground(Color("mainColor"))
                    .disabled(inEdit)
                }
                
                Section(header: Text(LocalizedStringKey("competition_add_title_shots"))) {
                    TextField(LocalizedStringKey("competition_add_shootcount"), text: $shoot_count)
                        .keyboardType(.numberPad)
                        .disabled(inEdit)
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
                                TextField(LocalizedStringKey("competition_add_shot \(3 * i + n + 1)"), text: Binding(
                                            get: { shots[num] },
                                            set: { shots[num] = $0.replacingOccurrences(of: ",", with: ".") }))
                                    .keyboardType(.decimalPad)
                                    .disabled(inEdit)
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
                                TextField(LocalizedStringKey("competition_add_shot \(num + 1)"), text: Binding(
                                            get: { shots[num] },
                                            set: { shots[num] = $0.replacingOccurrences(of: ",", with: ".") }))
                                    .keyboardType(.decimalPad)
                                    .disabled(inEdit)
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
                
                Section(header: Text(LocalizedStringKey("competition_add_title_info"))) {
                    HStack {
                        Text(LocalizedStringKey("competition_add_total"))
                        Spacer()
                        Text("\(totalRings, specifier: "%.1f")")
                            .onChange(of: shots, perform: { value in
                                calculateInformation()
                            })
                    }
                }
                
                Section(header: Text(LocalizedStringKey("competition_add_title_report"))) {
                    TextEditor(text: $report)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
                        .ignoresSafeArea(.keyboard)
                        .disabled(inEdit)
                }
                
                Section {
                    Button(action: { self.showingAlert.toggle() }, label: {
                        HStack {
                            Spacer()
                            Text(LocalizedStringKey("competition_add_share"))
                                .bold()
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                    })
                    .listRowBackground(Color("mainColor"))
                    .disabled(!inEdit)
                    Button(action: { updateCompetition(competition: competition) }, label: {
                        HStack {
                            Spacer()
                            Text(LocalizedStringKey("competition_add_save"))
                                .bold()
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                    })
                    .listRowBackground(Color("mainColor"))
                    .disabled(inEdit)
                }
            }
            .onAppear(perform: {
                // Set the data from the database
                self.competitionKind = HelperCompetitionKind.Kind(rawValue: competition.kind ?? "competition_add_kind_league") ?? HelperCompetitionKind.Kind.league
                self.location = competition.place ?? ""
                self.date = competition.date ?? Date()
                if (competition.image != nil) {
                    self.pickedImages.append(UIImage(data: competition.image ?? Data())!)
                }
                self.shoot_count = String(competition.shoot_count)
                self.shots = competition.shoots?.map {
                    String($0)
                } ?? []
                self.report = competition.report ?? ""
                
                // Calculate the information
                calculateInformation()
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(LocalizedStringKey("general_soon_title")), message: Text(LocalizedStringKey("general_soon_text")), dismissButton: .default(Text(LocalizedStringKey("general_soon_button"))))
            }
            .navigationBarTitle(LocalizedStringKey("competition_details"))
            .navigationBarItems(
                trailing:
                    HStack(spacing: 20) {
                        Button(action: {
                            inEdit.toggle()
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                        Button(LocalizedStringKey("general_close"), action: {
                            presentationMode.wrappedValue.dismiss()
                        })
                    }
            )
            .sheet(isPresented: $isImagePickerViewPresented) {
                PhotoPicker(pickerResult: $pickedImages, isPresented: $isImagePickerViewPresented)
            }
            .toast(isPresenting: $showingSuccessAlert, duration: 3, tapToDismiss: false, alert: {
                AlertToast(type: .complete(Color("accentColor")), title: NSLocalizedString("competition_add_edit_success", comment: ""))
            }, completion: {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func updateCompetition(competition: Competition) {
        withAnimation {
            competition.kind = competitionKind.rawValue
            competition.date = date
            if (pickedImages.count > 0) {
                competition.image = pickedImages[0].jpegData(compressionQuality: 1)
            } else {
                competition.image = nil
            }
            competition.place = location
            competition.report = report
            competition.shoot_count = Int16(shoot_count) ?? 0
            competition.shoots = shots.compactMap(Double.init)
            
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
    
    private func calculateInformation() {
        let doubles = shots.compactMap(Double.init)
        self.totalRings = doubles.reduce(0, +)
    }
}

struct CompetitionDetails_Previews: PreviewProvider {
    
    @State static var competition = Competition()
    
    static var previews: some View {
        CompetitionDetails(inEdit: true, competition: $competition)
    }
}
