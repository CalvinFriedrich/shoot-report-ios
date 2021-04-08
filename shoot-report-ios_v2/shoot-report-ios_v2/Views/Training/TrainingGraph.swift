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
   
    
    func updateUIView(_ uiView: AAChartView, context: Context) {
        let aaChartModel = AAChartModel()
        .chartType(.spline)//Can be any of the chart types listed under `AAChartType`.
        .animationType(.bounce)
        .subtitle("subtitle")//The chart subtitle
        .dataLabelsEnabled(false) //Enable or disable the data labels. Defaults to false
        .tooltipValueSuffix("USD")//the value suffix of the chart tooltip
        .categories(["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                     "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
        .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
        .series([
            AASeriesElement()
                .name("Tokyo")
                .data(dataSet)
                ])
        aaChartModel.title("Hi")
        uiView.aa_drawChartWithChartModel(aaChartModel)
    }
        
    func makeUIView(context: Context) -> AAChartView {
        let aaChartView = AAChartView()
 
        return aaChartView
    }
}

struct TrainingGraph: View {
    @Binding var data: [Double]
    var body: some View {
        TrainingGraphUIView(dataSet: $data)
    }
}


//struct TrainingGraph_Previews: PreviewProvider {
//    @State static var def = [4.5, 5.5]
//    static var previews: some View {
//        TrainingGraph(dataSet: def)
//    }
//}
