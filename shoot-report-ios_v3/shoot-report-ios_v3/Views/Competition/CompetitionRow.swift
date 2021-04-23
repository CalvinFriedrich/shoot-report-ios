//
//  CompetitionRow.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 23.04.21.
//

import SwiftUI

struct CompetitionRow: View {
    @ObservedObject var competition: Competition
    
    var body: some View {
        HStack {
            
            HStack(spacing: 30.0) {
                Text("\(competition.score*6, specifier: "%.2f")")
                    .font(.title)
                
                VStack(alignment: .leading) {
                    Text(competition.competitionCase ?? "")
                        .font(.title2)
                    Text("\(competition.date ?? Date(), style: .date), in \(competition.place ?? "")")
                        .font(.subheadline)
                }
            }
        }
        .padding()
    }
}

struct CompetitionRow_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionRow(competition: Competition())
    }
}
