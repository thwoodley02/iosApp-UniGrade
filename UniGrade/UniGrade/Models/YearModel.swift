//
//  YearModel.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation

struct Year {
    private var title: String
    private(set) public var credits: Int
    private(set) public var weight: Double
    private var yearoverview: Overview
    
    
    init(title: String, credits: Int, weight: Double, yearoverview: Overview) {
        self.title = title
        self.credits = credits
        self.weight = weight
        self.yearoverview = yearoverview
    }
    
    func getAverageStr() -> String {
        return yearoverview.getAverageStr()    }
    func getAchievedStr() -> String {
        return yearoverview.getAchievedStr()    }
    func getCompleteStr() -> String {
        return yearoverview.getCompleteStr()    }
    func getAverage() -> Double {
        return yearoverview.average  }
    func getTitleStr() -> String {
        return "Year \(title)"    }
    func getCreditsStr() -> String {
        return "\(credits) Credits"    }
    func getWeightStr() -> String {
        return "\(yearoverview.roundToString(percentage: weight)) Weighting"    }
}
