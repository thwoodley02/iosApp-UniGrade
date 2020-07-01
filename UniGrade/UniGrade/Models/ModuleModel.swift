//
//  ModuleModel.swift
//  UniGrade
//
//  Created by Tom Woodley on 30/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation

struct Module {
    private(set) public var title: String
    private(set) public var credits: Int
    private(set) public var moduleOverview: Overview?
    private(set) public var assessments: [Assessment]?
    
    init(title: String, credits: Int, moduleOverview: Overview?, assessments: [Assessment]?) {
        self.title = title
        self.credits = credits
        self.moduleOverview = moduleOverview
        self.assessments = assessments
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
