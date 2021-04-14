//
//  TrainerView.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 12.04.21.
//

import SwiftUI

struct TrainerView: View {
    private let hostingUrl: String = "https://trainer.burkhardt-sport.solutions"
    
    private let validLocales: [String] = ["de", "en"]
    @State private var locale: String = Locale.current.regionCode ?? "en" .lowercased()
    
    @State private var selection: Tab = .equipment
    enum Tab {
        case equipment
        case technical
        case mental
    }
    
    @State private var selectedEquipment: Int = 0
    
    @State private var selectedTechnical: Int = 0
    
    @State private var selectedMental: Int = 0
    
    var body: some View {
        TabView(selection: $selection,
                content:  {
                    VStack {
                        Picker("equipment", selection: $selectedEquipment) {
                            Text("CLOTHES").tag(0)
                            Text("EQUIPMENT").tag(1)
                            Text("ACCESSORIES").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        switch selectedEquipment {
                            case 0: WebView(link: hostingUrl + "/" + locale + "/equipment_cloths.html")
                            case 1: WebView(link: hostingUrl + "/" + locale + "/equipment_sport.html")
                            case 2: WebView(link: hostingUrl + "/" + locale + "/equipment_equipment.html")
                            default: Text("Error")
                        }
                    }
                    .tabItem { Text("Equipment")}.tag(Tab.equipment)
                    
                    
                    VStack {
                        Picker("technical", selection: $selectedTechnical) {
                            Text("POSITIONING").tag(0)
                            Text("PROCEDURE").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        switch selectedTechnical {
                            case 0: WebView(link: hostingUrl + "/" + locale + "/tech_positioning.html")
                            case 1: WebView(link: hostingUrl + "/" + locale + "/tech_procedure.html")
                            default: Text("Error")
                        }
                    }
                    .tabItem { Text("Technical")}.tag(Tab.technical)
                    
                    
                    VStack {
                        Picker("mental", selection: $selectedMental) {
                            Text("REST").tag(0)
                            Text("MOTIVATION").tag(1)
                            Text("FOCUS").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        switch selectedMental {
                            case 0: WebView(link: hostingUrl + "/" + locale + "/mental_relax.html")
                            case 1: WebView(link: hostingUrl + "/" + locale + "/mental_motivation.html")
                            case 2: WebView(link: hostingUrl + "/" + locale + "/mental_focus.html")
                            default: Text("Error")
                        }
                    }
                    .tabItem { Text("Mental")}.tag(Tab.mental)
                })
            .onAppear(perform: {
                print(locale)
                if !validLocales.contains(locale) {
                    locale = "en"
                }
            })
    }
}

struct TrainerView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerView()
    }
}
