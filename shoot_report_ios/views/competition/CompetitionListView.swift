import SwiftUI

struct CompetitionListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showSheet = false
    @State private var info = Competition()
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Competition.date, ascending: false)], animation: .default)
    private var competitions: FetchedResults<Competition>
    
    var rifle: Rifle
    
    var body: some View {
        List {
            ForEach(competitions) { competition in
                if(competition.rifleId == rifle.id) {
                    CompetitionRow(showSheet: $showSheet, info: $info, competition: competition)
                }
            }
            .onDelete(perform: deleteCompetition)
        }
        .sheet(isPresented: $showSheet) {
            CompetitionDetails(inEdit: true, competition: $info)
        }
    }
    
    private func deleteCompetition(offsets: IndexSet) {
        withAnimation {
            viewContext.perform {
                offsets.map { competitions[$0] }.forEach(viewContext.delete)
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}

struct CompetitionListView_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionListView(rifle: Rifle())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
