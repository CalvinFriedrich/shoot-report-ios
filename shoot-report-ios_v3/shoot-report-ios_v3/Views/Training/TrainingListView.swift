//
//  TrainingListView.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 21.04.21.
//

import SwiftUI

struct TrainingListView: View {
    var rifleid: Int64
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Training.date, ascending: false)],
        animation: .default)
    private var trainings: FetchedResults<Training>
    
    @State private var showSheet = false
    
    var body: some View {
        List {
            ForEach(trainings) { training in
                
                if (training.rifleid == rifleid) {
                
                    Button(action: {
                        self.showSheet.toggle()
                    }, label:  {
                        TrainingRow(training: training)
                    })
                    .sheet(isPresented: $showSheet, content: {
                        TrainingEditor(training: training)
                    })
                }
            }
            .onDelete(perform: deleteTraining)
        }
    }
    
    private func deleteTraining(offsets: IndexSet) {
        withAnimation {
            offsets.map { trainings[$0] }.forEach(viewContext.delete)

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

struct TrainingListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingListView(rifleid: 1)
    }
}
