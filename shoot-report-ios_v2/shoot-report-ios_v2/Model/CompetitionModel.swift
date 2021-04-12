//
//  CompetitionModel.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 08.04.21.
//

import Foundation

class CompetitionModel: Identifiable {
    public var id: Int64 = 0
    
    public var competitionCase: String = ""
    public var place: String = ""
    public var date: Date = Date()
    public var shots: String = ""
    public var score: Double = 0
    public var comment: String = ""
    public var rifleid: Int64 = 0
}
