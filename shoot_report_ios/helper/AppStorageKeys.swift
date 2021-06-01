//
//  AppStorageKeys.swift
//  shoot_report_ios
//
//  Created by Lars Helmuth Probst on 29.04.21.
//

import Foundation

struct AppStorageKeys {
    
    static let poemTitle_1 = "1_goals_tenth_40_jackpot"
    static let poemTitle_2 = "2_goals_tenth_40_jackpot"
    
    static func getRightName(rifleId: Int16) -> String {
        if(rifleId == 1) {
            return self.poemTitle_1
        } else {
            return self.poemTitle_2
        }
        
    }
}
