//
//  CompetitionStatsView.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 23.04.21.
//

import SwiftUI

struct CompetitionStatsView: View {
    var rifleid: Int64
    
    @State var whole: [Double] = []
    @State var tenth: [Double] = []
    @State var datesWhole: [String] = []
    @State var datesTenth: [String] = []
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Competition.date, ascending: true)],
        animation: .default)
    private var competitions: FetchedResults<Competition>
    
    var body: some View {
        VStack {
            CompetitionGraph(data: $whole, dates: $datesWhole, whole: true)

            CompetitionGraph(data: $tenth, dates: $datesTenth, whole: false)
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
            
        //loop through all competitions
        for competition in competitions {
            var rings = competition.score
            let helper:Date = competition.date ?? Date()
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

struct CompetitionStatsView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionStatsView(rifleid: 1)
    }
}
