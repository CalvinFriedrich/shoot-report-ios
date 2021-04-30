//
//  GoalsView_old.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 26.04.21.
//

import SwiftUI

struct GoalsView_old: View {
    var rifleid: Int64
    
    @State private var selectedTab: Int = 0
    @State var name: String = ""
    @State var content: String = ""
    @State var key: String = ""
    
    @State var showPopup: Bool = false

    var body: some View {
        ZStack {
            //basic view
            VStack {
                Picker("Goals", selection: $selectedTab) {
                    Text("WHOLE RINGS").tag(0)
                    Text("TENTH OF A RING").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                switch selectedTab {
                    case 0:
                        VStack {
                            Group {
                                Text("My goals 40 shots").foregroundColor(.green)
                                    .padding()
                                
                                Button(action: {
                                    showPopup = true
                                    name = "Jackpot"
                                    key = "goals_\(rifleid)_whole_Jackpot_40"
                                    content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Jackpot_40") ?? ""
                                }, label: {
                                    GoalsRow_old(name: "Jackpot", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Jackpot_40") ?? "")
                                })
                                
                                Button(action: {
                                    showPopup = true
                                    name = "Optimal"
                                    key = "goals_\(rifleid)_whole_Optimal_40"
                                    content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Optimal_40") ?? ""
                                }, label: {
                                    GoalsRow_old(name: "Optimal", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Optimal_40") ?? "")
                                })
                                
                                Button(action: {
                                    showPopup = true
                                    name = "Real"
                                    key = "goals_\(rifleid)_whole_Real_40"
                                    content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Real_40") ?? ""
                                }, label: {
                                    GoalsRow_old(name: "Real", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Real_40") ?? "")
                                })
                                
                                Button(action: {
                                    showPopup = true
                                    name = "Minimal"
                                    key = "goals_\(rifleid)_whole_Minimal_40"
                                    content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Minimal_40") ?? ""
                                }, label: {
                                    GoalsRow_old(name: "Minimal", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Minimal_40") ?? "")
                                })
                                
                                Button(action: {
                                    showPopup = true
                                    name = "Chaos"
                                    key = "goals_\(rifleid)_whole_Chaos_40"
                                    content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Chaos_40") ?? ""
                                }, label: {
                                    GoalsRow_old(name: "Chaos", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Chaos_40") ?? "")
                                })
                            }
                            
                            Divider()
                            
                            Text("My goals 60 shots").foregroundColor(.green)
                                .padding()
                            
                            Button(action: {
                                showPopup = true
                                name = "Jackpot"
                                key = "goals_\(rifleid)_whole_Jackpot_60"
                                content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Jackpot_60") ?? ""
                            }, label: {
                                GoalsRow_old(name: "Jackpot", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Jackpot_60") ?? "")
                            })
                            
                            Button(action: {
                                showPopup = true
                                name = "Optimal"
                                key = "goals_\(rifleid)_whole_Optimal_60"
                                content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Optimal_60") ?? ""
                            }, label: {
                                GoalsRow_old(name: "Optimal", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Optimal_60") ?? "")
                            })
                            
                            Button(action: {
                                showPopup = true
                                name = "Real"
                                key = "goals_\(rifleid)_whole_Real_60"
                                content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Real_60") ?? ""
                            }, label: {
                                GoalsRow_old(name: "Real", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Real_60") ?? "")
                            })
                            
                            Button(action: {
                                showPopup = true
                                name = "Minimal"
                                key = "goals_\(rifleid)_whole_Minimal_60"
                                content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Minimal_60") ?? ""
                            }, label: {
                                GoalsRow_old(name: "Minimal", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Minimal_60") ?? "")
                            })
                            
                            Button(action: {
                                showPopup = true
                                name = "Chaos"
                                key = "goals_\(rifleid)_whole_Chaos_60"
                                content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Chaos_60") ?? ""
                            }, label: {
                                GoalsRow_old(name: "Chaos", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_whole_Chaos_60") ?? "")
                            })
                        }
                    case 1:
                        VStack {
                            Group {
                                Text("My goals 40 shots").foregroundColor(.green)
                                    .padding()
                                
                                Button(action: {
                                    showPopup = true
                                    name = "Jackpot"
                                    key = "goals_\(rifleid)_tenth_Jackpot_40"
                                    content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Jackpot_40") ?? ""
                                }, label: {
                                    GoalsRow_old(name: "Jackpot", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Jackpot_40") ?? "")
                                })
                                
                                Button(action: {
                                    showPopup = true
                                    name = "Optimal"
                                    key = "goals_\(rifleid)_tenth_Optimal_40"
                                    content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Optimal_40") ?? ""
                                }, label: {
                                    GoalsRow_old(name: "Optimal", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Optimal_40") ?? "")
                                })
                                
                                Button(action: {
                                    showPopup = true
                                    name = "Real"
                                    key = "goals_\(rifleid)_tenth_Real_40"
                                    content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Real_40") ?? ""
                                }, label: {
                                    GoalsRow_old(name: "Real", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Real_40") ?? "")
                                })
                                
                                Button(action: {
                                    showPopup = true
                                    name = "Minimal"
                                    key = "goals_\(rifleid)_tenth_Minimal_40"
                                    content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Minimal_40") ?? ""
                                }, label: {
                                    GoalsRow_old(name: "Minimal", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Minimal_40") ?? "")
                                })
                                
                                Button(action: {
                                    showPopup = true
                                    name = "Chaos"
                                    key = "goals_\(rifleid)_tenth_Chaos_40"
                                    content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Chaos_40") ?? ""
                                }, label: {
                                    GoalsRow_old(name: "Chaos", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Chaos_40") ?? "")
                                })
                            }
                            
                            Divider()
                            
                            Text("My goals 60 shots").foregroundColor(.green)
                                .padding()
                            
                            Button(action: {
                                showPopup = true
                                name = "Jackpot"
                                key = "goals_\(rifleid)_tenth_Jackpot_60"
                                content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Jackpot_60") ?? ""
                            }, label: {
                                GoalsRow_old(name: "Jackpot", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Jackpot_60") ?? "")
                            })
                            
                            Button(action: {
                                showPopup = true
                                name = "Optimal"
                                key = "goals_\(rifleid)_tenth_Optimal_60"
                                content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Optimal_60") ?? ""
                            }, label: {
                                GoalsRow_old(name: "Optimal", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Optimal_60") ?? "")
                            })
                            
                            Button(action: {
                                showPopup = true
                                name = "Real"
                                key = "goals_\(rifleid)_tenth_Real_60"
                                content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Real_60") ?? ""
                            }, label: {
                                GoalsRow_old(name: "Real", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Real_60") ?? "")
                            })
                            
                            Button(action: {
                                showPopup = true
                                name = "Minimal"
                                key = "goals_\(rifleid)_tenth_Minimal_60"
                                content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Minimal_60") ?? ""
                            }, label: {
                                GoalsRow_old(name: "Minimal", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Minimal_60") ?? "")
                            })
                            
                            Button(action: {
                                showPopup = true
                                name = "Chaos"
                                key = "goals_\(rifleid)_tenth_Chaos_60"
                                content = UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Chaos_60") ?? ""
                            }, label: {
                                GoalsRow_old(name: "Chaos", content: UserDefaults.standard.string(forKey: "goals_\(rifleid)_tenth_Chaos_60") ?? "")
                            })
                        }
                    default: Text("Error")
                }
                
                Spacer()
            }
            
            //pop up
            
            if showPopup {
                ZStack {
                    Color.white
                    VStack {
                        Text(name).font(.title).bold()
                        TextField("Goal", text: $content)
                        HStack {
                            Spacer()
                            Button("CANCEL") {
                                self.showPopup = false
                            }
                            Button("OK") {
                                UserDefaults.standard.set(content, forKey: key)
                                self.showPopup = false
                            }
                        }
                    }
                    .padding()
                }
                .frame(width: 300, height: 150)
                .cornerRadius(20).shadow(radius: 20)
            }
        }
    }
}

struct GoalsView_old_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView_old(rifleid: 1)
    }
}
