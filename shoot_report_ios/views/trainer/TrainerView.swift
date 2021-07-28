import SwiftUI

struct TrainerView: View {
    var body: some View {
        VStack {
            TabView {
                TrainerEquipment()
                    .tabItem {
                        Image(systemName: "latch.2.case.fill")
                        Text(LocalizedStringKey("trainer_tab_equipment"))
                    }
                TrainerTech()
                    .tabItem {
                        Image(systemName: "gearshape.2.fill")
                        Text(LocalizedStringKey("trainer_tab_tech"))
                    }
                TrainerMental()
                    .tabItem {
                        Image("icon_mental")
                        Text(LocalizedStringKey("trainer_tab_mental"))
                    }
            }
            .accentColor(Color("menuColorSelected"))
            Spacer()
            ShareAd()
        }
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView()
    }
}
