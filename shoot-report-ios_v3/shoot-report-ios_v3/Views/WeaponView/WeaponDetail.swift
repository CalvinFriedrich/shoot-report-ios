//
//  WeaponDetail.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 21.04.21.
//

import SwiftUI

struct WeaponDetail: View {
    @State private var selection: Tab = .training
    var rifle: Rifle
    
    enum Tab {
        case training
        case competition
        case procedure
        case goals
    }
    
    @State private var showSheet = false
    
    var body: some View {
        TabView(selection: $selection) {
            
            TrainingView(rifleid: rifle.order)
                .tabItem {
                    Text("Training")
                }
                .tag(Tab.training)
            
            CompetitionView(rifleid: rifle.order)
                .tabItem {
                    Label("Competition", systemImage: "star.fill") }
                .tag(Tab.competition)
            
            ProcedureView(rifleid: rifle.order)
                .tabItem { Label("Procedure", systemImage: "list.bullet") }
                .tag(Tab.procedure)
            
            Text("Coming Soon!")
                .font(.title)
                .bold()
                .tabItem { Label("Goals", systemImage: "flag.fill") }
                .tag(Tab.goals)
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSheet, content: {
            
            if selection == .training {
                TrainingAdd(rifleid: rifle.order)
            } else if selection == .competition {
                CompetitionAdd(rifleid: rifle.order)
            }
            
        })
        .toolbar(content: {
            
            ToolbarItemGroup(placement: .navigationBarTrailing, content:  {
                
                NavigationLink(
                    destination: TrainerView(),
                    label: {
                        Image(systemName: "person.crop.circle")
                    })
                
                if selection == .training {
                    
                    Button(action: {
                        self.showSheet.toggle()
                    }, label:  {
                        Image(systemName: "plus")
                    })
                    
                } else if selection == .competition {
                    
                    Button(action: {
                        self.showSheet.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            })
            
        })
    }
}

struct WeaponDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeaponDetail(rifle: Rifle())
    }
}
