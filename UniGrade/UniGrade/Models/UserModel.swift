//
//  UserModel.swift
//  UniGrade
//
//  Created by Tom Woodley on 27/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation
import UIKit

class User {
    private(set) public var grandoverall: Overview?
    private(set) public var years: [Year]?
    private(set) public var targets: [Int]?
    
    init(grandoverall: Overview? = nil, years: [Year]? = nil, targets: [Int]? = nil) {
        self.grandoverall = grandoverall
        self.years = years
        self.targets = targets
    }
    
    func getTargetColor(target: CGFloat) -> UIColor {
        return UIColor.init(hue: (((93.0-17.0)*(target/100)) + 17.0)/360, saturation: 97.0/100.0, brightness: 77.0/100.0, alpha: 1.0)
    }
    
    func setTargets(targets: [Int]) {
        self.targets = targets
    }
    
    func getColorFromPercentage(percentage: Int) -> UIColor {
        switch percentage {
        case targets![0]:
            return UIColor(hue: 97.0/360.0, saturation: 0.9, brightness: 0.86, alpha: 1)
        case targets![1]:
            return UIColor(hue: 77.0/360.0, saturation: 0.9, brightness: 0.86, alpha: 1)
        case targets![2]:
            return UIColor(hue: 57.0/360.0, saturation: 0.9, brightness: 0.86, alpha: 1)
        case targets![3]:
            return UIColor(hue: 37.0/360.0, saturation: 0.9, brightness: 0.86, alpha: 1)
        default:
            return UIColor(hue: 104.0/360.0, saturation: 0.9, brightness: 0.86, alpha: 1)
        }
    }
    
    func addYear(year: Year) {
        if let years = self.years {
            self.years?.append(year)
        } else {
            self.years = [year]
        }
    }
}
