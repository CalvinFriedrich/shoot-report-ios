//
//  WeaponsListView.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 21.04.21.
//

import SwiftUI
import CoreData

struct WeaponsListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Rifle.order, ascending: true)],
        animation: .default)
    private var rifles: FetchedResults<Rifle>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rifles) { rifle in
                    NavigationLink(
                        destination: WeaponDetail(rifle: rifle))
                            {
                        WeaponRow(rifle: rifle)
                    }
                }
                .onDelete(perform: deleteRifles)
            }
            .navigationTitle("Rifles")
        }
        .onAppear(perform: {
            if !UserDefaults.standard.bool(forKey: "is_Preloaded") {
                addRifle(name: "Rifle 1", order: 1)
                addRifle(name: "Rifle 2", order: 2)
                addRifle(name: "Rifle 3", order: 3)
                addRifle(name: "Rifle 4", order: 4)
                addRifle(name: "Rifle 5", order: 5)

                UserDefaults.standard.set(true, forKey: "is_Preloaded")
            }
        })
    }

    private func addRifle(name: String, order: Int64) {
        
        withAnimation {
            let newRifle = Rifle(context: viewContext)
            newRifle.id = UUID()
            newRifle.name = name
            newRifle.order = order
            newRifle.shown = true
            

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

    private func deleteRifles(offsets: IndexSet) {
        withAnimation {
            offsets.map { rifles[$0] }.forEach(viewContext.delete)

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

struct WeaponsListView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponsListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
