//
//  YearModel.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation

struct Year {
    private(set) public var title: String
    private(set) public var credits: Int
    private(set) public var weight: Double
    private var yearoverview: Overview?
    private(set) public var modules: [Module]?
    
    
    init(title: String, credits: Int, weight: Double, yearoverview: Overview?, modules: [Module]?) {
        self.title = title
        self.credits = credits
        self.weight = weight
        self.yearoverview = yearoverview
        self.modules = modules
    }
    
    func getAverageStr() -> String {
        if let year = yearoverview {
            return year.getAverageStr()
        } else {
            return "-"
        }}
    func getAchievedStr() -> String {
        if let year = yearoverview {
            return year.getAchievedStr()
        } else {
            return "-"
        }}
    func getCompleteStr() -> String {
        if let year = yearoverview {
            return year.getCompleteStr()
        } else {
            return "-"
        }}
    func getAverage() -> Double {
        if let year = yearoverview {
            return year.average
        } else {
            return 0
        }}
    func getTitleStr() -> String {
        return "Year \(title)"    }
    func getCreditsStr() -> String {
        return "\(credits) Credits"    }
    func getWeightStr() -> String {
        return "\(Int(round(weight)))% Weight" }
    func getOverview() -> Overview? {
        if let overview = yearoverview {
            return overview
        } else {
            return nil
        }
    }
        
}
