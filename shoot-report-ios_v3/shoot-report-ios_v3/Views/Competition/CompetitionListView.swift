//
//  CompetitionListView.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 23.04.21.
//

import SwiftUI

struct CompetitionListView: View {
    var rifleid: Int64
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Competition.date, ascending: false)],
        animation: .default)
    private var competitions: FetchedResults<Competition>
    
    @State private var showSheet = false
    
    var body: some View {
        List {
            ForEach(competitions) { competition in
                
                if (competition.rifleid == rifleid) {
                
                    Button(action: {
                        self.showSheet.toggle()
                    }, label:  {
                        CompetitionRow(competition: competition)
                    })
                    .sheet(isPresented: $showSheet, content: {
                        CompetitionEditor(competition: competition)
                    })
                }
            }
            .onDelete(perform: deleteTraining)
        }
    }
    
    private func deleteTraining(offsets: IndexSet) {
        withAnimation {
            offsets.map { competitions[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct CompetitionListView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionListView(rifleid: 1)
    }
}
