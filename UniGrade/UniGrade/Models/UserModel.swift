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
    
    func updateUser() {
        var grandOverall: Overview? = nil
        if let years: [Year] = self.years {
            var max: Double = 0
            var mark: Double = 0
            for year in years {
                year.updateOverview()
                if let over: Overview = year.getOverview() {
                    max += (year.weight/100) * (over.complete/100)
                    mark += (year.weight/100) * (over.achieved/100)
                }
            }
            if max > 0
            {
                grandOverall = Overview(average: (mark/max) * 100, achieved: mark * 100, complete: max * 100)
            }
        }
        self.grandoverall = grandOverall
    }
    
    func getTargetColor(target: CGFloat) -> UIColor {
        return UIColor.init(hue: (((93.0-17.0)*(target/100)) + 17.0)/360, saturation: 97.0/100.0, brightness: 77.0/100.0, alpha: 1.0)
    }
    
    func setTargets(targets: [Int]) {
        self.targets = targets
    }
    
    func getColorFromPercentage(percentage: Int) -> UIColor {
        var hue: Double = 0
        if percentage > 70 {
            hue = 97.0 + (Double(percentage) - 70.0)
        } else if percentage < 40 {
            hue = 17.0 + (Double(percentage)*0.5)
        } else {
            hue = 37.0 + (Double(percentage - 40)*2)
        }
        return UIColor(hue: CGFloat(hue/360.0), saturation: 0.9, brightness: 0.86, alpha: 1)
    }
    
    func addYear(year: Year) {
        if let years = self.years {
            self.years?.append(year)
        } else {
            self.years = [year]
        }
    }
    
    func deleteYear(year: Year) {
        if let years = self.years {
            if let place = findYear(year: year) {
                self.years!.remove(at: place)
            }
        } else {
            self.years = [year]
        }
    }
    
    func findYear(year: Year) -> Int? {
        if let years = self.years {
            for i in 0..<years.count {
                if years[i].id == year.id {
                    return i
                }
            }
        }
        return nil
    }
    
    func updateYear(year: Year) {
        if let years = self.years {
            if let place = findYear(year: year) {
                self.years![place] = year
            }
        }
        
    }
    
    func removeTitleFromYear(year: Year) {
        if let years = self.years {
            if let place = findYear(year: year) {
                self.years![place].setTitle(title: "error")
            }
        }
    }
    
    func getThisYear(year: Year) -> Year? {
        if let place = findYear(year: year) {
            return years![place]
        }
        else {
            return nil
        }
    }
    
}
