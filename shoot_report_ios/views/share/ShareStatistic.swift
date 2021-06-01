import SwiftUI
import AAInfographics

struct ShareStatistic: UIViewRepresentable {
    
    @Binding var dataSet: [Double]
    @Binding var dateArray: [String]
    
    let title: String
    let color: String
    let name: String
    
    func updateUIView(_ uiView: AAChartView, context: Context) {
        let aaChartModel = AAChartModel()
            .chartType(.spline)
            .titleStyle(AAStyle().fontWeight(AAChartFontWeightType.bold))
            .zoomType(AAChartZoomType.xy)
            .backgroundColor("#FFFFFF")
            .yAxisTitle(NSLocalizedString("statistics_rings", comment: ""))
            .categories(dateArray)
            .title(title)
            .colorsTheme([color])
            .series([
                AASeriesElement()
                    .name(name)
                    .data(dataSet)
            ])
        
        uiView.aa_drawChartWithChartModel(aaChartModel)
    }
    
    func makeUIView(context: Context) -> AAChartView {
        return AAChartView()
    }
}

struct ShareStatistic_Previews: PreviewProvider {
    
    static let dataSet: [Double] = [4.5, 5.5]
    static let dateArray: [String] = ["14. April", "05.06."]
    static let whole = false
    
    static var previews: some View {
        ShareStatistic(dataSet: .constant(dataSet), dateArray: .constant(dateArray), title: "Tewst", color: "#fff", name: "Ø")
    }
}
