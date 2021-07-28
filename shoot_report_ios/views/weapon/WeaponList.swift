import SwiftUI
import CoreData

struct WeaponList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var showAlert = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Rifle.order, ascending: true)], animation: .default)
    private var rifles: FetchedResults<Rifle>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(rifles) { rifle in
                        if (rifle.show) {
                            NavigationLink(destination: MainView(rifle: rifle)) {
                                WeaponRow(rifle: rifle)
                            }
                            .padding(12)
                        }
                    }
                    .onDelete(perform: hideRifle)
                    .onMove(perform: move)
                }
                .listStyle(PlainListStyle())
                .navigationTitle(LocalizedStringKey("rifle_title"))
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            showAllRifles()
                        }) {
                            Image("icon_reload")
                        }
                        //EditButton()
                    }
                }
                Spacer()
                if (UIDevice.current.userInterfaceIdiom != .pad) {
                    ShareAd()
                }
            }
            .onAppear(perform: {
                upsertRifle(name: "rifle_1", order: 1, pref: 1)
                upsertRifle(name: "rifle_2", order: 2, pref: 2)
                upsertRifle(name: "rifle_3", order: 4, pref: 3)
                upsertRifle(name: "rifle_4", order: 5, pref: 4)
                upsertRifle(name: "rifle_5", order: 7, pref: 5)
                upsertRifle(name: "rifle_6", order: 9, pref: 6)
                upsertRifle(name: "rifle_7", order: 11, pref: 7)
                upsertRifle(name: "rifle_8", order: 3, pref: 8)
                upsertRifle(name: "rifle_9", order: 6, pref: 9)
                upsertRifle(name: "rifle_10", order: 8, pref: 10)
                upsertRifle(name: "rifle_11", order: 10, pref: 11)
                upsertRifle(name: "rifle_12", order: 12, pref: 12)
            })
        }
        .navigationBarColor(UIColor(Color("mainColor")))
    }
    
    private func upsertRifle(name: String, order: Int16, pref: Int16) {
        // Check if we have to add new rifle
        guard rifles.first(where: { $0.name == name }) != nil else {
            addRifle(name: name, order: order, pref: pref)
            return
        }
        
        // Check if we have to set the new order
        guard let changeOrder = rifles.first(where: { $0.name == name && $0.order != order || $0.name == name && $0.pref != pref }) else { return }
        updateOrder(rifle: changeOrder, order: order, pref: pref)
    }
    
    private func updateOrder(rifle: Rifle, order: Int16, pref: Int16) {
        withAnimation {
            rifle.order = order
            rifle.pref = pref
            
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
    
    private func addRifle(name: String, order: Int16, pref: Int16) {
        withAnimation {
            let newRifle = Rifle(context: viewContext)
            newRifle.id = UUID()
            newRifle.name = name
            newRifle.order = order
            newRifle.show = true
            newRifle.pref = pref
            
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
    
    private func hideRifle(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let rifle = rifles[index]
                rifle.show = false
            }
            
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
    
    func move(offsets: IndexSet, to: Int) {
        withAnimation {
            for index in offsets {
                let rifle = rifles[index]
                rifle.order = Int16(to)
            }
            
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
    
    private func showAllRifles() {
        withAnimation {
            // Sort them alphabetically
            //let rifles = rifles.sorted { $0.name! < $1.name! }
            rifles.forEach { rifle in
                rifle.show = true
            }
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
