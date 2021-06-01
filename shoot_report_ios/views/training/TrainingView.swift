import SwiftUI

struct TrainingView: View {
    
    @State private var selectedTab: Int = 0
    
    var rifle: Rifle
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("")) {
                Text(LocalizedStringKey("training_tab"))
                    .tag(0)
                Text(LocalizedStringKey("training_statistics"))
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch selectedTab {
            case 0:
                TrainingListView(rifle: rifle)
            case 1:
                TrainingStatistics(rifle: rifle)
            default:
                Text("default")
            }
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView(rifle: Rifle())
    }
}
