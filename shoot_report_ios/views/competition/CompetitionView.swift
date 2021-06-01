import SwiftUI

struct CompetitionView: View {
    
    @State private var selectedTab: Int = 0
    
    var rifle: Rifle
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("")) {
                Text(LocalizedStringKey("competition_tab"))
                    .tag(0)
                Text(LocalizedStringKey("competition_statistics"))
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch selectedTab {
            case 0:
                CompetitionListView(rifle: rifle)
            case 1:
                CompetitionStatistics(rifle: rifle)
            default:
                Text("default")
            }
        }
    }
}

struct CompetitionView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionView(rifle: Rifle())
    }
}
