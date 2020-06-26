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
    private var average: Double
    private var achieved: Double
    private var complete: Double
    
    
    init(title: String, average: Double, achieved: Double, complete: Double) {
        self.title = title
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
    func getTitle() -> String {
        return title    }
    
    
    func roundToString(percentage: Double) -> String {
        let per: Int = Int(round(percentage))
        return "\(per)%"
        }
    
}
