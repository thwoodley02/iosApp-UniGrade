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
        
        let user = User(grandoverall: nil, years: nil, targets: [70, 60, 50, 40])
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


