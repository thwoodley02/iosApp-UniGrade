//
//  DataFile.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    private var user = User()
    
    func initalise() {
        let yearOverview: Overview = Overview(average: 60, achieved: 5, complete: 6)
        let year1 = Year(title: "1", credits: 5, weight: 20, yearoverview: yearOverview)
        let year2 = Year(title: "2", credits: 5, weight: 20, yearoverview: yearOverview)
        let year3 = Year(title: "3", credits: 5, weight: 20, yearoverview: yearOverview)
        let year4 = Year(title: "4", credits: 5, weight: 20, yearoverview: yearOverview)
        let years = [year1, year2, year3, year4]
        
        let user = User(grandoverall: yearOverview, years: years, targets: [70, 60, 50, 40])
        self.user = user
    }
    
    func getUser() -> User {
        return user
    }
    
    func insertIntinIntList(newvalue data: Int, oldInts: [Int]) -> [Int] {
        var sortedInts: [Int] = []
        var isInserted = false
        for num in oldInts {
            if num > data || isInserted  {
                sortedInts.append(num)
            } else if isInserted == false {
                isInserted = true
                sortedInts.append(data)
                sortedInts.append(num)
            }
        }
        if isInserted == false {
            sortedInts.append(data)  }
        return sortedInts
    }
    
    
}


