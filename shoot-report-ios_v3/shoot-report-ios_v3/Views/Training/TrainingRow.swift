//
//  TrainingRow.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 21.04.21.
//

import SwiftUI

struct TrainingRow: View {
    @ObservedObject var training: Training
    
    var body: some View {
        HStack {
            
            HStack(spacing: 30.0) {
                Text(training.moodEmote ?? "")
                
                Text("\(training.score, specifier: "%.2f")")
                    .font(.title)
                
                VStack(alignment: .leading) {
                    Text(training.trainingCase ?? "")
                        .font(.title2)
                    Text("\(training.date ?? Date(), style: .date), in \(training.place ?? "")")
                        .font(.subheadline)
                }
            }
        }
        .padding()
    }
}

struct TrainingRow_Previews: PreviewProvider {
    static var previews: some View {
        TrainingRow(training: Training())
    }
}
