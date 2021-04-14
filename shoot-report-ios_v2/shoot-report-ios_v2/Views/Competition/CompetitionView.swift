//
//  CompetitionView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 08.04.21.
//

import SwiftUI

struct CompetitionView: View {
    var rifleid: Int64
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            Picker("Competition", selection: $selectedTab) {
                Text("COMPETITION").tag(0)
                Text("STATISTICS").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch selectedTab {
                case 0: CompetitionListView(rifleid: rifleid)
                case 1: CompetitionStatsView(rifleid: rifleid)
                default: Text("Error")
            }
        }
        .onAppear(perform: {
            selectedTab = 0
        })
    }
}

struct CompetitionView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionView(rifleid: 0)
    }
}
