import Foundation

class HelperCompetitionKind {
    
    public var kind = ""
    
    public enum Kind: String, CaseIterable, Identifiable {
        case league = "competition_add_kind_league"
        case round = "competition_add_kind_round"
        case championship = "competition_add_kind_championship"
        case control = "competition_add_kind_control"
        case other = "competition_add_kind_other"
        
        var id: String { self.rawValue }
    }
}
