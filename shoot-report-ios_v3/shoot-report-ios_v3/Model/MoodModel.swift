//
//  File.swift
//  shoot-report-ios_v3
//
//  Created by Calvin Friedrich on 21.04.21.
//

import Foundation

class MoodModel {
    public var moodEmote = Mood.happy
    
    public enum Mood: String, CaseIterable, Identifiable {
        case bad = "😧"
        case ok = "🙁"
        case fine = "🙂"
        case happy = "😁"
        
        var id: String { self.rawValue }
    }
}
