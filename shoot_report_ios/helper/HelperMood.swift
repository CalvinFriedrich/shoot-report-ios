import Foundation

class HelperMood {
    
    public var moodEmote = Mood.happy
    
    public enum Mood: String, CaseIterable, Identifiable {
        case bad = "😧"
        case ok = "🙁"
        case fine = "🙂"
        case happy = "😁"
        
        var id: String { self.rawValue }
    }
}
