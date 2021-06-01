import SwiftUI

struct MainView: View {
    
    enum ModalView {
        case information
        case partner
        case addTraining
        case addCompetition
    }
    
    enum Tab {
        case training
        case competition
        case procedure
        case goals
    }
    
    @Environment(\.openURL) var openURL
    
    @State private var showSheet = false
    @State private var showUserData = false
    @State private var showTrainer = false
    @State private var selection: Tab = .training
    @State private var modalView: ModalView = .information
    
    var rifle: Rifle
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                TrainingView(rifle: rifle)
                    .tabItem {
                        Image("icon_equipment")
                        Text(LocalizedStringKey("training_menu"))
                    }
                    .tag(Tab.training)
                CompetitionView(rifle: rifle)
                    .tabItem {
                        Image("icon_competition")
                        Text(LocalizedStringKey("competition_menu"))
                    }
                    .tag(Tab.competition)
                ProcedureView(rifle: rifle)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text(LocalizedStringKey("procedure_tab"))
                    }
                    .tag(Tab.procedure)
                GoalView(rifle: rifle)
                    .tabItem {
                        Image(systemName: "flag.fill")
                        Text(LocalizedStringKey("goals_tab"))
                    }
                    .tag(Tab.goals)
            }
            .accentColor(Color("mainColor"))
            Spacer()
            ShareAd()
                .navigationBarTitle(LocalizedStringKey(rifle.name!))
                .sheet(isPresented: $showSheet) {
                    if self.modalView == .information {
                        MenuInformationView()
                    } else if self.modalView == .partner {
                        MenuPartnerView()
                    } else if self.modalView == .addTraining {
                        TrainingAdd(rifle: rifle)
                    } else if self.modalView == .addCompetition {
                        CompetitionAdd(rifle: rifle)
                    }
                }
                .background(
                    HStack {
                        NavigationLink(destination: DataView().navigationBarTitle(LocalizedStringKey("user_title")), isActive: $showUserData) {}
                        NavigationLink(destination: TrainerView().navigationBarTitle(LocalizedStringKey("trainer_title")), isActive: $showTrainer) {}
                    }
                )
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showUserData = true
                        }) {
                            Image(systemName: "person.crop.circle.fill")
                        }
                        Button(action: {
                            self.showTrainer = true
                        }) {
                            Image("icon_trainer")
                        }
                        if self.selection == .training {
                            Button(action: {
                                self.modalView = .addTraining
                                self.showSheet.toggle()
                            }) {
                                Image("icon_add")
                            }
                        } else if self.selection == .competition {
                            Button(action: {
                                self.modalView = .addCompetition
                                self.showSheet.toggle()
                            }) {
                                Image("icon_add")
                            }
                        }
                        Menu(content: {
                            /*Button(action: {}) {
                             Text(LocalizedStringKey("menu_export"))
                             }*/
                            Button(action: {
                                self.modalView = .information
                                self.showSheet.toggle()
                            }) {
                                Text(LocalizedStringKey("menu_information"))
                            }
                            Button(action: {
                                self.modalView = .partner
                                self.showSheet.toggle()
                            }) {
                                Text(LocalizedStringKey("menu_partner"))
                            }
                            Button(action: {
                                openURL(URL(string: "https://www.facebook.com/shoot.report")!)
                            }) {
                                Text(LocalizedStringKey("menu_facebook"))
                            }
                            Button(action: {
                                openURL(URL(string: "https://www.instagram.com/shoot.report")!)
                            }) {
                                Text(LocalizedStringKey("menu_instagram"))
                            }
                        }, label: {
                            Image("icon_menu")
                        })
                    }
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(rifle: Rifle())
    }
}
