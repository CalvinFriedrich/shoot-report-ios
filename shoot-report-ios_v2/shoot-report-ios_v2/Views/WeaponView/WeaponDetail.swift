//
//  WeaponDetail.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 17.03.21.
//

import SwiftUI

struct WeaponDetail: View {
    @State private var selection: Tab = .training
    var rifleid: Int64
    
    enum Tab {
        case training
        case competition
        case procedure
        case goals
    }
    
    var body: some View {
        TabView(selection: $selection) {
            
            TrainingView(rifleid: rifleid)
                .tabItem {
                    VStack {
                        Text("Training")
                        Image("trainingIcon")
                            .resizable()
                            .scaledToFill()
                    }
                }
                .tag(Tab.training)
            
            CompetitionView(rifleid: rifleid)
                .tabItem {
                    Label("Competition", systemImage: "star.fill") }
                .tag(Tab.competition)
            
            Text("Coming Soon!")
                .font(.title)
                .bold()
                .tabItem { Label("Procedure", systemImage: "list.bullet") }
                .tag(Tab.procedure)
            
            Text("Coming Soon!")
                .font(.title)
                .bold()
                .tabItem { Label("Goals", systemImage: "flag.fill") }
                .tag(Tab.goals)
 
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            
            ToolbarItemGroup(placement: .navigationBarTrailing, content:  {
                
                NavigationLink(
                    destination: TrainerView(),
                    label: {
                        Image(systemName: "person.crop.circle")
                })
                
                if selection == .training {
                    NavigationLink(
                        destination: TrainingAdd(rifleid: rifleid),
                        label: {
                            Image(systemName: "plus")
                    })
                } else if selection == .competition {
                    NavigationLink(
                        destination: CompetitionAdd(rifleid: rifleid),
                        label: {
                            Image(systemName: "plus")
                    })
                }
            })
            
        })

    }
}

struct WeaponDetail_Previews: PreviewProvider {
    @State static var id: Int64 = 0
    
    static var previews: some View {
        WeaponDetail(rifleid: id)
    }
}
