//
//  CompetitionRow.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 08.04.21.
//

import SwiftUI

struct CompetitionRow: View {
    var idValue: Int64
    
    @State var competitionCase: String = ""
    @State var place: String = ""
    @State var date: Date = Date()
    @State var score: Double = 0
    
    var body: some View {
        HStack {
            
            HStack(spacing: 30.0) {
                Text("\(score*6, specifier: "%.2f")")
                    .font(.title)
                
                VStack(alignment: .leading) {
                    Text(competitionCase)
                        .font(.title2)
                    Text("\(date, style: .date), in \(place)")
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .onAppear(perform: {
            let competition = DB_Manager().getCompetition(idValue: self.idValue)
            
            self.competitionCase = competition.competitionCase
            self.place = competition.place
            self.date = competition.date
            self.score = competition.score
        })
    }
}

struct CompetitionRow_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionRow(idValue: 0)
    }
}
