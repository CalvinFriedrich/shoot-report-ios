import SwiftUI

struct GoalViewWhole: View {
    
    @State var goals40Jackpot: String = ""
    @State var goals40Optimal: String = ""
    @State var goals40Real: String = ""
    @State var goals40Minimal: String = ""
    @State var goals40Chaos: String = ""
    @State var goals60Jackpot: String = ""
    @State var goals60Optimal: String = ""
    @State var goals60Real: String = ""
    @State var goals60Minimal: String = ""
    @State var goals60Chaos: String = ""
    
    var rifle: Rifle
    
    var body: some View {
        Form {
            Section(header:
                        Text(LocalizedStringKey("goals_40"))
                        .foregroundColor(Color("accentColor"))
                        .bold()
                        .textCase(nil)) {
                HStack(spacing: 10) {
                    Image("arrow_jackpot")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("goals_jackpot"))
                        TextField(LocalizedStringKey("goals_input"), text: $goals40Jackpot)
                            .foregroundColor(.gray)
                            .onChange(of: goals40Jackpot) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "goals_whole_40_jackpot_\(rifle.pref)")
                            }
                            .keyboardType(.decimalPad)
                    }
                }
                HStack(spacing: 10) {
                    Image("arrow_optimistic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("goals_optimistic"))
                        TextField(LocalizedStringKey("goals_input"), text: $goals40Optimal)
                            .foregroundColor(.gray)
                            .onChange(of: goals40Optimal) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "goals_whole_40_optimal_\(rifle.pref)")
                            }
                            .keyboardType(.decimalPad)
                    }
                }
                HStack(spacing: 10) {
                    Image("arrow_real")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("goals_real"))
                        TextField(LocalizedStringKey("goals_input"), text: $goals40Real)
                            .foregroundColor(.gray)
                            .onChange(of: goals40Real) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "goals_whole_40_real_\(rifle.pref)")
                            }
                            .keyboardType(.decimalPad)
                    }
                }
                HStack(spacing: 10) {
                    Image("arrow_minimal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("goals_minimal"))
                        TextField(LocalizedStringKey("goals_input"), text: $goals40Minimal)
                            .foregroundColor(.gray)
                            .onChange(of: goals40Minimal) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "goals_whole_40_minimal_\(rifle.pref)")
                            }
                            .keyboardType(.decimalPad)
                    }
                }
                HStack(spacing: 10) {
                    Image("arrow_chaos")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("goals_chaos"))
                        TextField(LocalizedStringKey("goals_input"), text: $goals40Chaos)
                            .foregroundColor(.gray)
                            .onChange(of: goals40Chaos) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "goals_whole_40_chaos_\(rifle.pref)")
                            }
                            .keyboardType(.decimalPad)
                    }
                }
            }
            
            Section(header:
                        Text(LocalizedStringKey("goals_60"))
                        .foregroundColor(Color("accentColor"))
                        .bold()
                        .textCase(nil)) {
                HStack(spacing: 10) {
                    Image("arrow_jackpot")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("goals_jackpot"))
                        TextField(LocalizedStringKey("goals_input"), text: $goals60Jackpot)
                            .foregroundColor(.gray)
                            .onChange(of: goals60Jackpot) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "goals_whole_60_jackpot_\(rifle.pref)")
                            }
                            .keyboardType(.decimalPad)
                    }
                }
                HStack(spacing: 10) {
                    Image("arrow_optimistic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("goals_optimistic"))
                        TextField(LocalizedStringKey("goals_input"), text: $goals60Optimal)
                            .foregroundColor(.gray)
                            .onChange(of: goals60Optimal) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "goals_whole_60_optimal_\(rifle.pref)")
                            }
                            .keyboardType(.decimalPad)
                    }
                }
                HStack(spacing: 10) {
                    Image("arrow_real")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("goals_real"))
                        TextField(LocalizedStringKey("goals_input"), text: $goals60Real)
                            .foregroundColor(.gray)
                            .onChange(of: goals60Real) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "goals_whole_60_real_\(rifle.pref)")
                            }
                            .keyboardType(.decimalPad)
                    }
                }
                HStack(spacing: 10) {
                    Image("arrow_minimal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("goals_minimal"))
                        TextField(LocalizedStringKey("goals_input"), text: $goals60Minimal)
                            .foregroundColor(.gray)
                            .onChange(of: goals60Minimal) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "goals_whole_60_minimal_\(rifle.pref)")
                            }
                            .keyboardType(.decimalPad)
                    }
                }
                HStack(spacing: 10) {
                    Image("arrow_chaos")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("goals_chaos"))
                        TextField(LocalizedStringKey("goals_input"), text: $goals60Chaos)
                            .foregroundColor(.gray)
                            .onChange(of: goals60Chaos) { newValue in
                                UserDefaults.standard.set(newValue, forKey: "goals_whole_60_chaos_\(rifle.pref)")
                            }
                            .keyboardType(.decimalPad)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .onAppear(perform: {
            self.goals40Jackpot = UserDefaults.standard.string(forKey: "goals_whole_40_jackpot_\(rifle.pref)") ?? ""
            self.goals40Optimal = UserDefaults.standard.string(forKey: "goals_whole_40_optimal_\(rifle.pref)") ?? ""
            self.goals40Real = UserDefaults.standard.string(forKey: "goals_whole_40_real_\(rifle.pref)") ?? ""
            self.goals40Minimal = UserDefaults.standard.string(forKey: "goals_whole_40_minimal_\(rifle.pref)") ?? ""
            self.goals40Chaos = UserDefaults.standard.string(forKey: "goals_whole_40_chaos_\(rifle.pref)") ?? ""
            self.goals60Jackpot = UserDefaults.standard.string(forKey: "goals_whole_60_jackpot_\(rifle.pref)") ?? ""
            self.goals60Optimal = UserDefaults.standard.string(forKey: "goals_whole_60_optimal_\(rifle.pref)") ?? ""
            self.goals60Real = UserDefaults.standard.string(forKey: "goals_whole_60_real_\(rifle.pref)") ?? ""
            self.goals60Minimal = UserDefaults.standard.string(forKey: "goals_whole_60_minimal_\(rifle.pref)") ?? ""
            self.goals60Chaos = UserDefaults.standard.string(forKey: "goals_whole_60_chaos_\(rifle.pref)") ?? ""
        })
    }
}

struct GoalViewWhole_Previews: PreviewProvider {
    static var previews: some View {
        GoalViewWhole(rifle: Rifle())
    }
}
