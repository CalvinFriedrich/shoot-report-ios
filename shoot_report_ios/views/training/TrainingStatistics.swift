import SwiftUI

struct TrainingStatistics: View {
    
    var rifle: Rifle
    
    @State var whole: [Double] = []
    @State var tenth: [Double] = []
    @State var datesWhole: [String] = []
    @State var datesTenth: [String] = []
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Training.date, ascending: true)], animation: .default)
    private var trainings: FetchedResults<Training>
    
    var body: some View {
        VStack {
            ShareStatistic(dataSet: $whole, dateArray: $datesWhole, title: NSLocalizedString("statistics_training_whole_rings", comment: ""), color: "#0AE20A", name: NSLocalizedString("statistics_training", comment: ""))
            ShareStatistic(dataSet: $tenth, dateArray: $datesTenth, title: NSLocalizedString("statistics_training_tenth_rings", comment: ""), color: "#0E2435", name: NSLocalizedString("statistics_training", comment: ""))
        }
        .onAppear(perform: {
            getData()
        })
    }
    
    private func getData() {
        whole = []
        tenth = []
        datesWhole = []
        datesTenth = []
        
        for training in trainings.reversed() {
            if(training.rifleId == rifle.id) {
                let rings = training.shoots!.reduce(0, +)
                var average = 0.0
                if (training.shoot_count != 0) {
                    average = rings / Double(training.shoot_count)
                }
                
                let helper = training.date ?? Date()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                
                if(rings.truncatingRemainder(dividingBy: 1) == 0 && whole.count < 10) {
                    whole.append(round(average * 100) / 100)
                    datesWhole.append((formatter.string(from: helper)))
                } else if (rings.truncatingRemainder(dividingBy: 1) != 0 && tenth.count < 10) {
                    tenth.append(round(average * 100) / 100)
                    datesTenth.append((formatter.string(from: helper)))
                }
            }
        }
        
        // Reverse all data
        whole = whole.reversed()
        tenth = tenth.reversed()
        datesWhole = datesWhole.reversed()
        datesTenth = datesTenth.reversed()
    }
}

struct TrainingStatistics_Previews: PreviewProvider {
    static var previews: some View {
        TrainingStatistics(rifle: Rifle())
    }
}
