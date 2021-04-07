//
//  TrainingView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 17.03.21.
//

import SwiftUI

struct TrainingView: View {
    var rifleid: Int64
    
    var body: some View {
        TabView {
            TrainingListView(rifleid: rifleid)
                .tabItem { Text("TRAINING").font(.title) }
            TrainingStatsView(rifleid: rifleid)
                .tabItem { Text("STATISTICS").font(.title) }
        }
    }
}

struct TrainingView_Previews: PreviewProvider {
    @State static var id: Int64 = 0
    
    static var previews: some View {
        TrainingView(rifleid: id)
    }
}
