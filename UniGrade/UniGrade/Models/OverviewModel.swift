//
//  OverviewModel.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation

class Overview {
    private(set) public var average: Double
    private(set) public var achieved: Double
    private(set) public var complete: Double
    
    init(average: Double, achieved: Double, complete: Double) {
        self.average = average
        self.achieved = achieved
        self.complete = complete
    }
    
    func getAverageStr() -> String {
        return roundToString(percentage: average)    }
    func getAchievedStr() -> String {
        return roundToString(percentage: achieved)    }
    func getCompleteStr() -> String {
        return roundToString(percentage: complete)    }
    
    
    func roundToString(percentage: Double) -> String {
        let per: Int = Int(round(percentage))
        return "\(per)%"
    }
}
