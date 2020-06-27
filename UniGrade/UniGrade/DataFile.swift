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
        let yearOverview: Overview = Overview(average: 80, achieved: 5, complete: 6)
        let year1 = Year(title: "One", credits: 5, weight: 20, yearoverview: yearOverview)
        let year2 = Year(title: "Two", credits: 5, weight: 20, yearoverview: yearOverview)
        let year3 = Year(title: "Three", credits: 5, weight: 20, yearoverview: yearOverview)
        let year4 = Year(title: "Four", credits: 5, weight: 20, yearoverview: yearOverview)
        let years = [year1, year2, year3, year4]
        
        let user = User(grandoverall: yearOverview, years: years, targets: [75, 60, 50, 40, 30, 20, 10, 80, 90, 100, 0])
        self.user = user
    }
    
    func getUser() -> User {
        return user
    }
    
    
    
}


