//
//  TrainingGraph.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 07.04.21.
//



import SwiftUI
import AAInfographics

struct TrainingGraphUIView: UIViewRepresentable {
    @Binding var dataSet: [Double]
    @Binding var dateArray: [String]
    var whole: Bool
   
    
    func updateUIView(_ uiView: AAChartView, context: Context) {
        let aaChartModel = AAChartModel()
            .chartType(.spline)
            .titleStyle(AAStyle().fontWeight(AAChartFontWeightType.bold))
            .zoomType(AAChartZoomType.xy)
            .backgroundColor("#FAFAFA")
            .yAxisTitle("Rings")
            .categories(dateArray)
            .series([
                AASeriesElement()
                    .name("Ø")
                    .data(dataSet)
                ])
        
        if whole == true {
            aaChartModel
                .title("Ø Shot whole rings")
                .colorsTheme(["#0AE20A"])
        } else {
            aaChartModel
                .title("Ø Shot tenth of a ring")
                .colorsTheme(["#0E2435"])
        }
            

        
        uiView.aa_drawChartWithChartModel(aaChartModel)
    }
        
    func makeUIView(context: Context) -> AAChartView {
        let aaChartView = AAChartView()
 
        return aaChartView
    }
}

struct TrainingGraph: View {
    @Binding var data: [Double]
    @Binding var dates: [String]
    var whole: Bool
    var body: some View {
        TrainingGraphUIView(dataSet: $data, dateArray: $dates, whole: whole)
    }
}


//struct TrainingGraph_Previews: PreviewProvider {
//    @State static var def = [4.5, 5.5]
//    @State static var datum = ["14. April", "05.06."]
//    static var previews: some View {
//        TrainingGraph(data: def, dates: datum)
//    }
//}
