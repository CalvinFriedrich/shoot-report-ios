import SwiftUI

struct DataPerson: View {
    
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
    }
}

struct DataPerson_Previews: PreviewProvider {
    static var previews: some View {
        DataPerson()
    }
}
