//
//  YearModel.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation

class Year {
    private(set) public var id: Int64
    private(set) public var title: String
    private(set) public var credits: Int
    private(set) public var weight: Double
    private var yearoverview: Overview?
    private(set) public var modules: [Module]?
    
    
    init(id: Int64, title: String, credits: Int, weight: Double, yearoverview: Overview?, modules: [Module]?) {
        self.id = id
        self.title = title
        self.credits = credits
        self.weight = weight
        self.yearoverview = yearoverview
        self.modules = modules
    }
    
    func updateOverview() {
        if let modules: [Module] = modules {
            for module in modules {
                module.updateOverview()
                
            }
        }
        
        var yearOverview: Overview? = nil
        if let modules: [Module] = modules {
            var max: Double = 0
            var mark: Double = 0
            
            for mods in modules {
                mods.updateOverview()
                if let over: Overview = mods.moduleOverview {
                    max += ((Double(mods.credits)/Double(self.credits)) * (Double(over.complete)/100))
                    mark += ((Double(mods.credits)/Double(self.credits)) * (Double(over.achieved)/100))
                }
            }
            if max > 0 {
                yearOverview = Overview(average: (mark/max)*100, achieved: mark * 100, complete: max * 100)
            }
        }
        self.yearoverview = yearOverview
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
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func addModule(module: Module) {
        if modules != nil {
            modules!.append(module)
        } else {
            modules = [module]
        }
    }
        
}
