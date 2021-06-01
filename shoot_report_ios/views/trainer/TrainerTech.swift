import SwiftUI

struct TrainerTech: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("")) {
                Text(LocalizedStringKey("trainer_tab_tech_positioning")).tag(0)
                Text(LocalizedStringKey("trainer_tab_tech_procedure")).tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            
            TabView(selection: $selectedTab) {
                TrainerTab(request: "tech_positioning.html").tag(0)
                TrainerTab(request: "tech_procedure.html").tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct TrainerTech_Previews: PreviewProvider {
    static var previews: some View {
        TrainerTech()
    }
}
