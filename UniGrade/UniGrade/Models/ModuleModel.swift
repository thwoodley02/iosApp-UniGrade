//
//  ModuleModel.swift
//  UniGrade
//
//  Created by Tom Woodley on 30/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation

class Module {
    private(set) public var id: Int64
    private(set) public var title: String
    private(set) public var credits: Int
    private(set) public var moduleOverview: Overview?
    private(set) public var assessments: [Assessment]?
    
    init(id: Int64, title: String, credits: Int, moduleOverview: Overview?, assessments: [Assessment]?) {
        self.id = id
        self.title = title
        self.credits = credits
        self.moduleOverview = moduleOverview
        self.assessments = assessments
    }
    
    func updateOverview() {
        var moduleOverview: Overview? = nil
        if let assessments: [Assessment] = assessments {
            var max: Double = 0
            var mark: Double = 0
            
            for asses in assessments {
                if !asses.isPlaceholder {
                    max += (asses.weight/100)
                    mark += ((asses.mark/100) * (asses.weight/100))
                }
            }
            if max > 0 {
                moduleOverview = Overview(average: (mark/max)*100, achieved: mark * 100, complete: max * 100)
            }
        }
        self.moduleOverview = moduleOverview
    }
    
    func getAverageStr() -> String {
        if let overview = moduleOverview {
            return overview.getAverageStr()
        } else {
            return "-"
        }}
    func getAchievedStr() -> String {
        if let overview = moduleOverview {
            return overview.getAchievedStr()
        } else {
            return "-"
        }}
    func getCompleteStr() -> String {
        if let overview = moduleOverview {
            return overview.getCompleteStr()
        } else {
            return "-"
        }}
    func getAverage() -> Double {
        if let overview = moduleOverview {
            return overview.average
        } else {
            return 0
        }}
    func getTitleStr() -> String {
        return "\(title)"    }
    func getCreditsStr() -> String {
        return "\(credits) Credits"    }
}
