import SwiftUI

struct CompetitionRow: View {
    
    @Binding var showSheet: Bool
    @Binding var info: Competition
    
    @ObservedObject var competition: Competition
    
    var body: some View {
        Button(action: {
            self.info = competition
            self.showSheet.toggle()
        }) {
            HStack(alignment: .center, spacing: 30) {
                calcPoints(points: competition.shoots ?? [0])
                    .frame(width: 45, alignment: .leading)
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey(competition.kind ?? ""))
                    Text("\(competition.date ?? Date(), formatter: itemFormatter), in \(competition.place ?? "")")
                }
                Spacer()
            }
        }
    }
    
    private func calcPoints(points: [Double]) -> Text {
        let sum = points.reduce(0, +)
        if (sum.truncatingRemainder(dividingBy: 1) == 0) {
            return Text(String(format: "%.0f", sum))
        } else {
            return Text(String(format: "%.1f", sum))
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct CompetitionRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let competition = Competition(context: context)
        CompetitionRow(showSheet: .constant(false), info: .constant(Competition()), competition: competition)
    }
}
