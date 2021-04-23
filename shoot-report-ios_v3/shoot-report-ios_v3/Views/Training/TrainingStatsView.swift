//
//  TrainingStatsView.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 21.04.21.
//

import SwiftUI

struct TrainingStatsView: View {
    var rifleid: Int64
    
    @State var whole: [Double] = []
    @State var tenth: [Double] = []
    @State var datesWhole: [String] = []
    @State var datesTenth: [String] = []
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Training.date, ascending: true)],
        animation: .default)
    private var trainings: FetchedResults<Training>
    
    var body: some View {
        VStack {
            TrainingGraph(data: $whole, dates: $datesWhole, whole: true)

            TrainingGraph(data: $tenth, dates: $datesTenth, whole: false)
        }
        .onAppear(perform: {
            getData(rifleid: rifleid)
        })
    }
    
    private func getData(rifleid: Int64) {
        whole = []
        tenth = []
        datesWhole = []
        datesTenth = []
            
        //loop through all trainings
        for training in trainings {
            var rings = training.score
            let helper:Date = training.date ?? Date()
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .short
            let date = (formatter1.string(from: helper))
                
            //check if the result is an integer (= a score with whole rings)
            if floor(rings) == rings {
                whole.append(rings)
                datesWhole.append(date)
            } else {
                rings = round(rings * 100) / 100
                tenth.append(rings)
                datesTenth.append(date)
            }
                
        }
    }
}

struct TrainingStatsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingStatsView(rifleid: 1)
    }
}
