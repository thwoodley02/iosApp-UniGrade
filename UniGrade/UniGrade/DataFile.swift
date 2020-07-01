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
        
        let genOverview: Overview = Overview(average: 65, achieved: 6.5, complete: 10)
        let asses = Assessment(id: 0, title: "Whole Module", isPlaceholder: false, weight: 50, mark: 60)
        let genmodule = Module(id: 1, title: "Computer Vision", credits: 20, moduleOverview: genOverview, assessments: [asses])
        let year1 = Year(id: 2, title: "1", credits: 120, weight: 20, yearoverview: genOverview, modules: [genmodule])
        let year2 = Year(id: 3, title: "2", credits: 120, weight: 20, yearoverview: genOverview, modules: [genmodule])
        let year3 = Year(id: 4, title: "3", credits: 120, weight: 20, yearoverview: genOverview, modules: nil)
        let year4 = Year(id: 5, title: "4", credits: 120, weight: 20, yearoverview: nil, modules: nil)
        let years = [year1, year2, year3, year4]
        
        let user = User(grandoverall: genOverview, years: years, targets: [70, 60, 50, 40])
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


