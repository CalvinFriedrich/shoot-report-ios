import SwiftUI

struct CompetitionStatistics: View {
    
    var rifle: Rifle
    
    @State var whole: [Double] = []
    @State var tenth: [Double] = []
    @State var datesWhole: [String] = []
    @State var datesTenth: [String] = []
    @State var areTenth: Bool = false
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Competition.date, ascending: true)], animation: .default)
    private var competitions: FetchedResults<Competition>
    
    var body: some View {
        VStack {
            ShareStatistic(dataSet: $whole, dateArray: $datesWhole, title: NSLocalizedString("statistics_competition_whole_rings", comment: ""), color: "#0AE20A", name: NSLocalizedString("statistics_competition", comment: ""))
            ShareStatistic(dataSet: $tenth, dateArray: $datesTenth, title: NSLocalizedString("statistics_competition_tenth_rings", comment: ""), color: "#0E2435", name: NSLocalizedString("statistics_competition", comment: ""))
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
        
        for competition in competitions.reversed() {
            if (competition.rifleId == rifle.id) {
                let rings = competition.shoots!.reduce(0, +)
                areTenth = false
                let helper = competition.date ?? Date()
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                
                if (competition.shoots?.count != 0) {
                    for i in competition.shoots! {
                        if (!areTenth && (Double(Int(i)) != i)) {
                            areTenth = true
                        }
                    }
                }
                
                if (!areTenth && whole.count < 10) {
                    whole.append(round(rings * 100) / 100)
                    datesWhole.append((formatter.string(from: helper)))
                } else if (areTenth && tenth.count < 10) {
                    tenth.append(round(rings * 100) / 100)
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

struct CompetitionStatistics_Previews: PreviewProvider {
    static var previews: some View {
        CompetitionStatistics(rifle: Rifle())
    }
}
