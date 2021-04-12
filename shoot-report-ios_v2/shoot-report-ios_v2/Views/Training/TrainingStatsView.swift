//
//  TrainingStatsView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 18.03.21.
//

import SwiftUI

struct TrainingStatsView: View {
    @State var whole: [Double] = [5]
    @State var tenth: [Double] = []
    @State var datesWhole: [String] = []
    @State var datesTenth: [String] = []
    var rifleid: Int64
    
    var body: some View {
        VStack {
            TrainingGraph(data: $whole, dates: $datesWhole, whole: true)

            TrainingGraph(data: $tenth, dates: $datesTenth, whole: false)
        }
        .onAppear(perform: {
            (self.whole, self.tenth, self.datesWhole, self.datesTenth) = DB_Manager().getTrainingGraph(weaponid: rifleid)
        })
    }
}
struct TrainingStatsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingStatsView(rifleid: 0)
    }
}
