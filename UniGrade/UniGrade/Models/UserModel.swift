//
//  UserModel.swift
//  UniGrade
//
//  Created by Tom Woodley on 27/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation

class User {
    private(set) public var grandoverall: Overview?
    private(set) public var years: [Year]?
    private(set) public var targets: [Int]?
    
    init(grandoverall: Overview? = nil, years: [Year]? = nil, targets: [Int]? = nil) {
        self.grandoverall = grandoverall
        self.years = years
        self.targets = targets
    }
}
