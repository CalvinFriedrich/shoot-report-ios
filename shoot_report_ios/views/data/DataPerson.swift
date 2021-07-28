import SwiftUI
import PhotosUI

struct DataPerson: View {
    
    @State var pickedImages: [UIImage] = []
    @State var isImagePickerViewPresented = false
    @State var user_name: String = ""
    @State var user_age: String = ""
    @State var user_height: String = ""
    @State var user_club_1: String = ""
    @State var user_club_2: String = ""
    @State var user_trainer: String = ""
    @State var user_trainer_mail: String = ""
    @State var user_squad_trainer: String = ""
    @State var user_squad_trainer_mail: String = ""
    
    var body: some View {
        Form {
            Section(header: Text(LocalizedStringKey("user_tab_person_gunner"))) {
                TextField(LocalizedStringKey("user_tab_person_name"), text: $user_name)
                    .onChange(of: user_name) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "user_name")
                    }
                TextField(LocalizedStringKey("user_tab_person_age"), text: $user_age)
                    .onChange(of: user_age) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "user_age")
                    }
                TextField(LocalizedStringKey("user_tab_height"), text: $user_height)
                    .onChange(of: user_height) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "user_height")
                    }
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
                .onChange(of: pickedImages, perform: { newValue in
                    if newValue.count != 0 {
                        let image = newValue[0]
                        if let data = image.pngData() {
                            // Create URL
                            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                            let url = documents.appendingPathComponent("profile.png")
                            
                            do {
                                // Write to Disk
                                try data.write(to: url)
                                
                                // Store URL in User Defaults
                                UserDefaults.standard.set(url, forKey: "user_picture")
                                
                            } catch {
                                print("Unable to Write Data to Disk (\(error))")
                            }
                        }
                    } else {
                        UserDefaults.standard.removeObject(forKey: "user_picture")
                    }
                })
                
            }
            
            Section(header: Text(LocalizedStringKey("user_tab_person_club"))) {
                TextField(LocalizedStringKey("user_tab_person_club_1"), text: $user_club_1)
                    .onChange(of: user_club_1) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "user_club_1")
                    }
                TextField(LocalizedStringKey("user_tab_person_club_2"), text: $user_club_2)
                    .onChange(of: user_club_2) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "user_club_2")
                    }
            }
            
            Section(header: Text(LocalizedStringKey("user_tab_person_trainer"))) {
                TextField(LocalizedStringKey("user_tab_person_trainer"), text: $user_trainer)
                    .onChange(of: user_trainer) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "user_trainer")
                    }
                TextField(LocalizedStringKey("user_tab_person_trainermail"), text: $user_trainer_mail)
                    .onChange(of: user_trainer_mail) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "user_trainer_mail")
                    }
                TextField(LocalizedStringKey("user_tab_person_squadtrainer"), text: $user_squad_trainer)
                    .onChange(of: user_squad_trainer) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "user_squad_trainer")
                    }
                TextField(LocalizedStringKey("user_tab_person_squadtraineremail"), text: $user_squad_trainer_mail)
                    .onChange(of: user_squad_trainer_mail) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "user_squad_trainer_mail")
                    }
            }
        }
        .listStyle(GroupedListStyle())
        .gesture(DragGesture())
        .onAppear(perform: {
            if let url = UserDefaults.standard.url(forKey: "user_picture") {
                let data = try? Data(contentsOf: url)
                self.pickedImages.append(UIImage(data: data!)!)
            }
            self.user_name = UserDefaults.standard.string(forKey: "user_name") ?? ""
            self.user_age = UserDefaults.standard.string(forKey: "user_age") ?? ""
            self.user_height = UserDefaults.standard.string(forKey: "user_height") ?? ""
            self.user_club_1 = UserDefaults.standard.string(forKey: "user_club_1") ?? ""
            self.user_club_2 = UserDefaults.standard.string(forKey: "user_club_2") ?? ""
            self.user_trainer = UserDefaults.standard.string(forKey: "user_trainer") ?? ""
            self.user_trainer_mail = UserDefaults.standard.string(forKey: "user_trainer_mail") ?? ""
            self.user_squad_trainer = UserDefaults.standard.string(forKey: "user_squad_trainer") ?? ""
            self.user_squad_trainer_mail = UserDefaults.standard.string(forKey: "user_squad_trainer_mail") ?? ""
        })
        .sheet(isPresented: $isImagePickerViewPresented) {
            PhotoPicker(pickerResult: $pickedImages, isPresented: $isImagePickerViewPresented)
        }
    }
}

struct DataPerson_Previews: PreviewProvider {
    static var previews: some View {
        DataPerson()
    }
}
