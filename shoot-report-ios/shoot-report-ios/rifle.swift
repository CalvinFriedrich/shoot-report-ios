//
//  rifle.swift
//  shoot-report-ios
//
//  Created by Calvin Friedrich on 10.03.21.
//

import UIKit

class rifle {
    
    //MARK: Properties
    
    var name: String
    
    
    //MARK: Initialization
    
    init?(name: String) {
        guard !name.isEmpty else {
            return nil
        }
        self.name = name
    }

    
}
