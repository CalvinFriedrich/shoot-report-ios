import SwiftUI

struct ProcedureView: View {
    
    @State private var selectedTab: Int = 0
    
    var rifle: Rifle
    
    var body: some View {
        VStack {
            Picker(selection: $selectedTab, label: Text("")) {
                Text(LocalizedStringKey("procedure_tab_before"))
                    .tag(0)
                Text(LocalizedStringKey("procedure_tab_during"))
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch selectedTab {
            case 0:
                ProcedurePreparation(rifle: rifle)
            case 1:
                ProcedureShot(rifle: rifle)
            default:
                Text("default")
            }
        }
    }
}

struct ProcedureView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureView(rifle: Rifle())
    }
}
