//
//  CompetitionStatsView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 08.04.21.
//

import SwiftUI

struct CompetitionStatsView: View {
    @State var whole: [Double] = [5]
    @State var tenth: [Double] = []
    @State var datesWhole: [String] = []
    @State var datesTenth: [String] = []
    var rifleid: Int64
    
    var body: some View {
        VStack {
            CompetitionGraph(data: $whole, dates: $datesWhole, whole: true)

            CompetitionGraph(data: $tenth, dates: $datesTenth, whole: false)
        }
        .onAppear(perform: {
            (self.whole, self.tenth, self.datesWhole, self.datesTenth) = DB_Manager().getCompetitionGraph(weaponid: rifleid)
        })
    }
}
struct CompetitionStatsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingStatsView(rifleid: 0)
    }
}
