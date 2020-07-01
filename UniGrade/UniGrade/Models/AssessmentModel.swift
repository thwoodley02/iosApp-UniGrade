//
//  AssessmentModel.swift
//  UniGrade
//
//  Created by Tom Woodley on 30/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation

class Assessment {
    private(set) public var id: Int64
    private(set) public var title: String
    private(set) public var isPlaceholder: Bool
    private(set) public var weight: Double
    private(set) public var mark: Double
    
    init(id: Int64, title: String, isPlaceholder: Bool, weight: Double, mark: Double) {
        self.id = id
        self.title = title
        self.isPlaceholder = false
        self.weight = weight
        self.mark = mark
    }
}
