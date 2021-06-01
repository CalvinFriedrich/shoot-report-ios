import SwiftUI

struct TrainingRow: View {
    
    @Binding var isPresented: Bool
    @Binding var info: Training
    
    @ObservedObject var training: Training
    
    var body: some View {
        Button(action: {
            self.isPresented.toggle()
            self.info = training
        }){
            HStack(alignment: .center, spacing: 30) {
                Text(training.indicator ?? "")
                    .frame(width: 30, alignment: .center)
                self.calcPoints(points: training.shoots ?? [0])
                    .frame(width: 45, alignment: .leading)
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey(training.training ?? ""))
                    Text("\(training.date ?? Date(), formatter: dateFormater), in \(training.place ?? "")")
                }
                Spacer()
            }
        }
    }
    
    private func calcPoints(points: [Double]) -> Text {
        let sum = points.reduce(0, +)
        if(sum.truncatingRemainder(dividingBy: 1) == 0) {
            return Text(String(format: "%.0f", sum))
        } else {
            return Text(String(format: "%.1f", sum))
        }
    }
}

private let dateFormater: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct TrainingRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        let training = Training(context: context)
        TrainingRow(isPresented: .constant(false), info: .constant(Training()), training: training)
    }
}
