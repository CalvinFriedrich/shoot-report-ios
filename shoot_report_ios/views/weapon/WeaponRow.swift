import SwiftUI

struct WeaponRow: View {
    
    @ObservedObject var rifle: Rifle
    
    var body: some View {
        HStack() {
            Image("icon_weapon")
            Text(LocalizedStringKey(rifle.name ?? ""))
        }
    }
}

struct WeaponRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let rifle = Rifle(context: context)
        WeaponRow(rifle: rifle)
    }
}
