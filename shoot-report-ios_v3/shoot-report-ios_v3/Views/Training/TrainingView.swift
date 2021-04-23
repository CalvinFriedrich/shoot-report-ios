//
//  TrainingView.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 21.04.21.
//

import SwiftUI

struct TrainingView: View {
    var rifleid: Int64
    @State private var selectedTab: Int = 0
    
    var body: some View {
        
        VStack {
            Picker("Training", selection: $selectedTab) {
                Text("TRAINING").tag(0)
                Text("STATISTICS").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch selectedTab {
            case 0: TrainingListView(rifleid: rifleid)
                case 1: TrainingStatsView(rifleid: rifleid)
                default: Text("Error")
            }
        }
        .onAppear(perform: {
            selectedTab = 0
        })
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView(rifleid: 1)
    }
}
