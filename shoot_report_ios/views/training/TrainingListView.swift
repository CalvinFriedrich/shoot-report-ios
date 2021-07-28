import SwiftUI

struct TrainingListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isPresented = false
    @State private var info = Training()
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Training.date, ascending: false)], animation: .default)
    private var trainings: FetchedResults<Training>
    
    var rifle: Rifle
    
    var body: some View {
        List {
            ForEach(trainings) { training in
                if (training.rifleId == rifle.id) {
                    TrainingRow(isPresented: $isPresented, info: $info, training: training)
                }
            }
            .onDelete(perform: deleteTraining)
        }
        .sheet(isPresented: $isPresented) {
            TrainingDetails(inEdit: true, training: $info)
        }
    }
    
    private func deleteTraining(offsets: IndexSet) {
        withAnimation {
            viewContext.perform {
                offsets.map {
                    trainings[$0]
                }.forEach(viewContext.delete)
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

struct TrainingListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingListView(rifle: Rifle())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
