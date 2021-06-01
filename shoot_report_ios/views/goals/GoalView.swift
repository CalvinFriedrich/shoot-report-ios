import SwiftUI

struct GoalView: View {
    
    @State private var selectedTab: Int = 0
    @AppStorage("username") var username = ""
    
    var rifle: Rifle
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("")) {
                Text(LocalizedStringKey("goals_tab_whole"))
                    .tag(0)
                Text(LocalizedStringKey("goals_tab_tenth"))
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch selectedTab {
            case 0:
                GoalViewWhole(rifle: rifle)
            case 1:
                GoalViewTenth(rifle: rifle)
            default:
                Text("default")
            }
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(rifle: Rifle())
    }
}
