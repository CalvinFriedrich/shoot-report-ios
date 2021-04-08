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
    var rifleid: Int64
    
    var body: some View {
        VStack {
            TrainingGraph(data: $whole)

            TrainingGraph(data: $tenth)
        }
        .onAppear(perform: {
            (self.whole, self.tenth) = DB_Manager().getGraph(weaponid: rifleid)
        })
    }
}
struct TrainingStatsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingStatsView(rifleid: 0)
    }
}
