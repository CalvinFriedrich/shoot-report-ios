import SwiftUI

struct TrainerEquipment: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("")) {
                Text(LocalizedStringKey("trainer_tab_equipment_clothes")).tag(0)
                Text(LocalizedStringKey("trainer_tab_equipment_equipment")).tag(1)
                Text(LocalizedStringKey("trainer_tab_equipment_accessories")).tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            
            TabView(selection: $selectedTab) {
                TrainerTab(request: "equipment_cloths.html").tag(0)
                TrainerTab(request: "equipment_sport.html").tag(1)
                TrainerTab(request: "equipment_equipment.html").tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct TrainerEquipment_Previews: PreviewProvider {
    static var previews: some View {
        TrainerEquipment()
    }
}
