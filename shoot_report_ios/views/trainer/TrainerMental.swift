import SwiftUI

struct TrainerMental: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("")) {
                Text(LocalizedStringKey("trainer_tab_mental_rest")).tag(0)
                Text(LocalizedStringKey("trainer_tab_mental_motivation")).tag(1)
                Text(LocalizedStringKey("trainer_tab_mental_focus")).tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            
            TabView(selection: $selectedTab) {
                TrainerTab(request: "mental_relax.html").tag(0)
                TrainerTab(request: "mental_motivation.html").tag(1)
                TrainerTab(request: "mental_focus.html").tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct TrainerMental_Previews: PreviewProvider {
    static var previews: some View {
        TrainerMental()
    }
}
