//
//  Training.swift
//  shoot-report-ios_v2
//
//  Created by Calvin Friedrich on 18.03.21.
//

import Foundation

class TrainingModel: Identifiable {
    public var id: Int64 = 0
    
    public var trainingCase: String = ""
    public var place: String = ""
    public var date: Date = Date()
    public var count: Int64 = 0
    public var shots: String = ""
    public var score: Double = 0
    public var comment: String = ""
    public var rifleid: Int64 = 0
    
    public var moodEmote = Mood.happy
    
    public enum Mood: String, CaseIterable, Identifiable {
        case bad = "😧"
        case ok = "🙁"
        case fine = "🙂"
        case happy = "😁"
        
        var id: String { self.rawValue }
    }
}
