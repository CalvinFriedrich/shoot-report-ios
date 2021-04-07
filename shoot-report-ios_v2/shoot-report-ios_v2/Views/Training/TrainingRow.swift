//
//  TrainingRow.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 18.03.21.
//

import SwiftUI

struct TrainingRow: View {
    var idValue: Int64
    
    @State var trainingCase: String = ""
    @State var place: String = ""
    @State var date: Date = Date()
    @State var moodEmote: TrainingModel.Mood = TrainingModel.Mood.happy
    @State var score: Double = 0
    
    var body: some View {
        HStack {
            
            HStack(spacing: 30.0) {
                Text(moodEmote.rawValue)
                
                Text("\(score, specifier: "%.2f")")
                    .font(.title)
                
                VStack(alignment: .leading) {
                    Text(trainingCase)
                        .font(.title2)
                    Text("\(date, style: .date), in \(place)")
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .onAppear(perform: {
            let training = DB_Manager().getTraining(idValue: self.idValue)
            
            self.moodEmote = training.moodEmote
            self.trainingCase = training.trainingCase
            self.place = training.place
            self.date = training.date
            self.score = training.score
        })
    }
}

struct TrainingRow_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRow(idValue: 0)
    }
}
