//
//  TrainingStatsView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 18.03.21.
//

import SwiftUI
import SwiftUICharts

struct TrainingStatsView: View {
    @State var whole: [Double] = []
    @State var tenth: [Double] = []
    var rifleid: Int64
    
    var body: some View {
        VStack {
            LineView(data: whole, title: "Ø Shot whole rings", legend: "Rings")
                .padding()
            
            LineView(data: tenth, title: "Ø Shot tenth of a ring", legend: "Rings")
                .padding()
                
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
 
