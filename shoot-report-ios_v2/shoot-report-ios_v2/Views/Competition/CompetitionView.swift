//
//  CompetitionView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 08.04.21.
//

import SwiftUI

struct CompetitionView: View {
    var rifleid: Int64
    
    var body: some View {
        TabView {
            CompetitionListView(rifleid: rifleid)
                .tabItem { Text("COMPETITION").font(.title) }
            CompetitionStatsView(rifleid: rifleid)
                .tabItem { Text("STATISTICS").font(.title) }
        }
    }
}

struct CompetitionView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionView(rifleid: 0)
    }
}
