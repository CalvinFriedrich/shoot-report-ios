//
//  WeaponRow.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 21.04.21.
//

import SwiftUI

struct WeaponRow: View {
    var rifle: Rifle
    
    var body: some View {
        HStack(spacing: 20.0) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 30, height: 30)
            Text(rifle.name ?? "").font(.title)
        }
        .padding()
    }
}

struct WeaponRow_Previews: PreviewProvider {
    static var previews: some View {
        WeaponRow(rifle: Rifle())
    }
}
