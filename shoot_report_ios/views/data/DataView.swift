import SwiftUI

struct DataView: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            VStack {
                Picker(selection: $selectedTab, label: Text("")) {
                    Text(LocalizedStringKey("user_tab_person"))
                        .tag(0)
                    Text(LocalizedStringKey("user_tab_device"))
                        .tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TabView(selection: $selectedTab) {
                    DataPerson()
                        .tag(0)
                    DataDevice()
                        .tag(1)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        Spacer()
        ShareAd()
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
