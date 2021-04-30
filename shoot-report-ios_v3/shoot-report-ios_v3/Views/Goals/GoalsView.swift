//
//  GoalsView.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 27.04.21.
//

import SwiftUI

struct GoalsView: View {
    @State private var selectedTab: Int = 0
    
    @AppStorage("goals_01_whole_Jackpot_40") var goals_01_whole_Jackpot_40 = ""
    @AppStorage("goals_01_whole_Optimal_40") var goals_01_whole_Optimal_40 = ""
    @AppStorage("goals_01_whole_Real_40") var goals_01_whole_Real_40 = ""
    @AppStorage("goals_01_whole_Minimal_40") var goals_01_whole_Minimal_40 = ""
    @AppStorage("goals_01_whole_Chaos_40") var goals_01_whole_Chaos_40 = ""
    @AppStorage("goals_01_tenth_Jackpot_40") var goals_01_tenth_Jackpot_40 = ""
    @AppStorage("goals_01_tenth_Optimal_40") var goals_01_tenth_Optimal_40 = ""
    @AppStorage("goals_01_tenth_Real_40") var goals_01_tenth_Real_40 = ""
    @AppStorage("goals_01_tenth_Minimal_40") var goals_01_tenth_Minimal_40 = ""
    @AppStorage("goals_01_tenth_Chaos_40") var goals_01_tenth_Chaos_40 = ""
    
    @AppStorage("goals_01_whole_Jackpot_60") var goals_01_whole_Jackpot_60 = ""
    @AppStorage("goals_01_whole_Optimal_60") var goals_01_whole_Optimal_60 = ""
    @AppStorage("goals_01_whole_Real_60") var goals_01_whole_Real_60 = ""
    @AppStorage("goals_01_whole_Minimal_60") var goals_01_whole_Minimal_60 = ""
    @AppStorage("goals_01_whole_Chaos_60") var goals_01_whole_Chaos_60 = ""
    @AppStorage("goals_01_tenth_Jackpot_60") var goals_01_tenth_Jackpot_60 = ""
    @AppStorage("goals_01_tenth_Optimal_60") var goals_01_tenth_Optimal_60 = ""
    @AppStorage("goals_01_tenth_Real_60") var goals_01_tenth_Real_60 = ""
    @AppStorage("goals_01_tenth_Minimal_60") var goals_01_tenth_Minimal_60 = ""
    @AppStorage("goals_01_tenth_Chaos_60") var goals_01_tenth_Chaos_60 = ""
    var body: some View {
        VStack {
            Picker("Goals", selection: $selectedTab) {
                Text("WHOLE RINGS").tag(0)
                Text("TENTH OF A RING").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            switch selectedTab {
            case 0:
                Form {
                    Section(header: Text("My goals 40 shots").foregroundColor(.green)
                                .padding()) {
                        HStack {
                            Image("Pfeil_Jackpot").resizable()
                                .padding(.horizontal)
                            VStack {
                                Text("Jackpot")
                                TextField("Goal", text: $goals_01_whole_Jackpot_40)
                            }
                        }
                        
                        HStack {
                            Image("Pfeil_Optimal").resizable()
                                .padding(.horizontal)
                            VStack {
                                Text("Optimal")
                                TextField("Goal", text: $goals_01_whole_Optimal_40)
                            }
                        }
                        
                        HStack {
                            Image("Pfeil_Real").resizable()
                                .padding(.horizontal)
                            VStack {
                                Text("Real")
                                TextField("Goal", text: $goals_01_whole_Real_40)
                            }
                        }
                        
                        HStack {
                            Image("Pfeil_Minimal").resizable()
                                .padding(.horizontal)
                            VStack {
                                Text("Minimal")
                                TextField("Goal", text: $goals_01_whole_Minimal_40)
                            }
                        }
                        
                        HStack {
                            Image("Pfeil_Chaos").resizable()
                                .padding(.horizontal)
                            VStack {
                                Text("Chaos")
                                TextField("Goal", text: $goals_01_whole_Chaos_40)
                            }
                        }
                    }
                    
                    Section(header: Text("My goals 60 shots").foregroundColor(.green)
                                .padding()) {
                        VStack {
                            Text("Jackpot")
                            TextField("Goal", text: $goals_01_whole_Jackpot_60)
                        }
                        
                        VStack {
                            Text("Optimal")
                            TextField("Goal", text: $goals_01_whole_Optimal_60)
                        }
                        
                        VStack {
                            Text("Real")
                            TextField("Goal", text: $goals_01_whole_Real_60)
                        }
                        
                        VStack {
                            Text("Minimal")
                            TextField("Goal", text: $goals_01_whole_Minimal_60)
                        }
                        
                        VStack {
                            Text("Chaos")
                            TextField("Goal", text: $goals_01_whole_Chaos_60)
                        }
                    }
                }
            case 1:
                Form {
                    Section(header: Text("My goals 40 shots").foregroundColor(.green)
                                .padding()) {
                        VStack {
                            Text("Jackpot")
                            TextField("Goal", text: $goals_01_tenth_Jackpot_40)
                        }
                        
                        VStack {
                            Text("Optimal")
                            TextField("Goal", text: $goals_01_tenth_Optimal_40)
                        }
                        
                        VStack {
                            Text("Real")
                            TextField("Goal", text: $goals_01_tenth_Real_40)
                        }
                        
                        VStack {
                            Text("Minimal")
                            TextField("Goal", text: $goals_01_tenth_Minimal_40)
                        }
                        
                        VStack {
                            Text("Chaos")
                            TextField("Goal", text: $goals_01_tenth_Chaos_40)
                        }
                    }
                    
                    Section(header: Text("My goals 60 shots").foregroundColor(.green)
                                .padding()) {
                        VStack {
                            Text("Jackpot")
                            TextField("Goal", text: $goals_01_tenth_Jackpot_60)
                        }
                        
                        VStack {
                            Text("Optimal")
                            TextField("Goal", text: $goals_01_tenth_Optimal_60)
                        }
                        
                        VStack {
                            Text("Real")
                            TextField("Goal", text: $goals_01_tenth_Real_60)
                        }
                        
                        VStack {
                            Text("Minimal")
                            TextField("Goal", text: $goals_01_tenth_Minimal_60)
                        }
                        
                        VStack {
                            Text("Chaos")
                            TextField("Goal", text: $goals_01_tenth_Chaos_60)
                        }
                    }
                }
            default: Text("Error")
            }
        }
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}
