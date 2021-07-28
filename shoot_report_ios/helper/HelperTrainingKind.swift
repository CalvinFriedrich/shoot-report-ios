import Foundation

class HelperTrainingKind {
    
    public var kind = ""
    
    public enum Kind: String, CaseIterable, Identifiable {
        case setUp = "training_add_kind_setup"
        case positioningSetUp = "training_add_kind_positioningSetUp"
        case zeroPoint = "training_add_kind_zeroPoint"
        case breathing = "training_add_kind_breathing"
        case aiming = "training_add_kind_aiming"
        case trigger = "training_add_kind_trigger"
        case coordination = "training_add_kind_coordination"
        case phaseTraining = "training_add_kind_phaseTraining"
        case leftPositioning = "training_add_kind_leftPositioning"
        case performanceTraining = "training_add_kind_performanceTraining"
        case competitionTraining = "training_add_kind_competitionTraining"
        case finalTraining = "training_add_kind_finalTraining"
        case other = "training_add_kind_other"
        
        var id: String {
            self.rawValue
        }
    }
}
