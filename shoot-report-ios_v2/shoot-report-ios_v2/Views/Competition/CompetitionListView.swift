//
//  CompetitionListView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 08.04.21.
//

import SwiftUI

struct CompetitionListView: View {
    var rifleid: Int64
    
    @State var competitions: [CompetitionModel] = []
    
    
    var body: some View {
        List(competitions) { competition in
            NavigationLink(
                destination: CompetitionEditor(id: competition.id)) {

                HStack {
                    CompetitionRow(idValue: competition.id)
                    
                    Spacer()
                    
                    Button(action: {
                        //create db manager instance
                        let dbManager: DB_Manager = DB_Manager()
                        
                        //call delete function
                        dbManager.deleteCompetition(idValue: competition.id)
                        
                        //refresh the competitions array
                        self.competitions = dbManager.getCompetitions(weaponid: rifleid)
                        
                    }, label: {
                        Image(systemName: "trash.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .onAppear(perform: {
            self.competitions = DB_Manager().getCompetitions(weaponid: rifleid)
        })
    }
}

struct CompetitionListView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionListView(rifleid: 1)
    }
}
