//
//  WeaponsListView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 17.03.21.
//

import SwiftUI

struct WeaponsListView: View {
    @State var weapons: [WeaponModel] = []
    
    var body: some View {
        NavigationView {
            List(weapons) { weapon in
                NavigationLink(
                    destination: WeaponDetail(rifleid: weapon.id))
                        {
                    HStack {
                        WeaponRow(rifleid: weapon.id)
                        Spacer()
                        Button(action: {
                            //create db manager instance
                            let dbManager: DB_Manager = DB_Manager()
                            
                            //call delete function
                            dbManager.deleteWeapon(idValue: weapon.id)
                            
                            //refresh the weapons array
                            self.weapons = dbManager.getWeapons()
                        }, label: {
                            Image(systemName: "trash.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        })
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                }
            }
            .navigationTitle("Rifles")
        }
        .onAppear(perform: {
            weapons = DB_Manager().getWeapons()
        })
    }
}

struct WeaponsListView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponsListView()
    }
}
