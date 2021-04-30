//
//  GoalsRow_old.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 26.04.21.
//

import SwiftUI

struct GoalsRow_old: View {
    var name: String
    @State var content: String
    
    
    var body: some View {
        HStack {
            switch name {
                case "Jackpot":
                    Image("Pfeil_Jackpot").resizable().scaledToFit().padding(.horizontal)
                case "Optimal":
                    Image("Pfeil_Optimal").resizable().scaledToFit().padding(.horizontal)
                case "Real":
                    Image("Pfeil_Real").resizable().scaledToFit().padding(.horizontal)
                case "Minimal":
                    Image("Pfeil_Minimal").resizable().scaledToFit().padding(.horizontal)
                case "Chaos":
                    Image("Pfeil_Chaos").resizable().scaledToFit().padding(.horizontal)
                default:
                    Image(systemName: "person.crop.circle").padding()
            }
            VStack(alignment: .leading) {
                Text(name)
                if content != "" {
                    Text(content)
                        .opacity(0.5)
                } else {
                    Text("Not Set")
                        .font(.subheadline)
                        .opacity(0.5)
                }
            }
            .foregroundColor(.black)
            
            Spacer()
        }
    }
}

struct GoalsRow_old_Previews: PreviewProvider {
    static var previews: some View {
        GoalsRow_old(name: "Jackpot", content: "")
    }
}
