import SwiftUI
import CoreData

struct WeaponList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @AppStorage("weapons_loaded") var weaponsLoaded = false
    
    @State var showAlert = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Rifle.order, ascending: true)], animation: .default)
    private var rifles: FetchedResults<Rifle>
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(rifles) { rifle in
                        if(rifle.show) {
                            NavigationLink(destination: MainView(rifle: rifle)) {
                                WeaponRow(rifle: rifle)
                            }
                            .padding(12)
                        }
                    }
                    .onDelete(perform: hideRifle)
                }
                .listStyle(PlainListStyle())
                .navigationTitle(LocalizedStringKey("rifle_title"))
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showAllRifles()
                        }) {
                            Image("icon_reload")
                        }
                    }
                }
                Spacer()
                ShareAd()
            }
            .onAppear(perform: {
                if (!weaponsLoaded) {
                    addRifle(name: "rifle_1", order: 1)
                    addRifle(name: "rifle_2", order: 2)
                    addRifle(name: "rifle_3", order: 3)
                    addRifle(name: "rifle_4", order: 4)
                    addRifle(name: "rifle_5", order: 5)
                    addRifle(name: "rifle_6", order: 6)
                    weaponsLoaded = true
                }
            })
        }
        .navigationBarColor(UIColor(Color("mainColor")))
    }
    
    private func addRifle(name: String, order: Int16) {
        withAnimation {
            let newRifle = Rifle(context: viewContext)
            newRifle.id = UUID()
            newRifle.name = name
            newRifle.order = order
            newRifle.show = true
            
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
    
    private func showAllRifles() {
        withAnimation {
            rifles.forEach{rifle in
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
