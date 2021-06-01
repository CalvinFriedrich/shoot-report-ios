import SwiftUI
import PhotosUI

struct CompetitionDetails: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var isImagePickerViewPresented = false
    @State private var showingAlert = false
    @State var inEdit: Bool = true
    @State var competitionKind: HelperCompetitionKind.Kind = HelperCompetitionKind.Kind.league
    @State var location: String = ""
    @State var date: Date = Date()
    @State var pickedImages: [UIImage] = []
    @State var shoot_count: String = ""
    @State var shots: [String] = ["", "", "", "", "", "", "", "", ""]
    @State var totalRings: Double = 0
    @State var report: String = ""
    
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
                            Image(uiImage: self.pickedImages[0])
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
                    HStack {
                        TextField(LocalizedStringKey("competition_add_shot1"), text: $shots[0])
                            .onChange(of: shots[0]) {
                                shots[0] = $0.replacingOccurrences(of: ",", with: ".")
                            }
                            .keyboardType(.decimalPad)
                            .disabled(inEdit)
                        TextField(LocalizedStringKey("competition_add_shot2"), text: $shots[1])
                            .onChange(of: shots[1]) {
                                shots[1] = $0.replacingOccurrences(of: ",", with: ".")
                            }
                            .keyboardType(.decimalPad)
                            .disabled(inEdit)
                        TextField(LocalizedStringKey("competition_add_shot3"), text: $shots[2])
                            .onChange(of: shots[2]) {
                                shots[2] = $0.replacingOccurrences(of: ",", with: ".")
                            }
                            .keyboardType(.decimalPad)
                            .disabled(inEdit)
                    }
                    HStack {
                        TextField(LocalizedStringKey("competition_add_shot4"), text: $shots[3])
                            .onChange(of: shots[3]) {
                                shots[3] = $0.replacingOccurrences(of: ",", with: ".")
                            }
                            .keyboardType(.decimalPad)
                            .disabled(inEdit)
                        TextField(LocalizedStringKey("competition_add_shot5"), text: $shots[4])
                            .onChange(of: shots[4]) {
                                shots[4] = $0.replacingOccurrences(of: ",", with: ".")
                            }
                            .keyboardType(.decimalPad)
                            .disabled(inEdit)
                        TextField(LocalizedStringKey("competition_add_shot6"), text: $shots[5])
                            .onChange(of: shots[5]) {
                                shots[5] = $0.replacingOccurrences(of: ",", with: ".")
                            }
                            .keyboardType(.decimalPad)
                            .disabled(inEdit)
                    }
                    HStack {
                        TextField(LocalizedStringKey("competition_add_shot7"), text: $shots[6])
                            .onChange(of: shots[6]) {
                                shots[6] = $0.replacingOccurrences(of: ",", with: ".")
                            }
                            .keyboardType(.decimalPad)
                            .disabled(inEdit)
                        TextField(LocalizedStringKey("competition_add_shot8"), text: $shots[7])
                            .onChange(of: shots[7]) {
                                shots[7] = $0.replacingOccurrences(of: ",", with: ".")
                            }
                            .keyboardType(.decimalPad)
                            .disabled(inEdit)
                        TextField(LocalizedStringKey("competition_add_shot9"), text: $shots[8])
                            .onChange(of: shots[8]) {
                                shots[8] = $0.replacingOccurrences(of: ",", with: ".")
                            }
                            .keyboardType(.decimalPad)
                            .disabled(inEdit)
                    }
                }
                
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
                if(competition.image != nil) {
                    self.pickedImages.append(UIImage(data: competition.image ?? Data())!)
                }
                self.shoot_count = String(competition.shoot_count)
                self.shots = competition.shoots?.map { String($0) } ?? ["0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0", "0.0"]
                if(self.shots.count < 9) {
                    for _ in 1...9-self.shots.count {
                        self.shots.append("")
                    }
                }
                self.report = competition.report ?? ""
                
                // Calculate the information
                self.calculateInformation()
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
        }
    }
    
    private func updateCompetition(competition: Competition) {
        withAnimation {
            competition.kind = self.competitionKind.rawValue
            competition.date = self.date
            if(self.pickedImages.count > 0) {
                competition.image = self.pickedImages[0].jpegData(compressionQuality: 1)
            } else {
                competition.image = nil
            }
            competition.place = self.location
            competition.report = self.report
            competition.shoot_count = Int16(self.shoot_count) ?? 0
            competition.shoots = self.shots.compactMap(Double.init)
            
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
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
