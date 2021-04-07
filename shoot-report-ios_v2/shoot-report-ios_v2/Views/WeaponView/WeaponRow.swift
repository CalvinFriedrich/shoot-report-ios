//
//  WeaponRow.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 17.03.21.
//

import SwiftUI

struct WeaponRow: View {
    var rifleid: Int64
    @State var name: String = ""
    
    var body: some View {
        HStack(spacing: 20.0) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 30, height: 30)
            Text(name).font(.title)
        }
        .padding()
        .onAppear(perform: {
            let weapon: WeaponModel = DB_Manager().getWeapon(idValue: rifleid)
            
            self.name = weapon.name
        })
    }
}

struct WeaponRow_Previews: PreviewProvider {
    static var previews: some View {
        WeaponRow(rifleid: 0)
    }
}
