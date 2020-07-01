//
//  AssessmentModel.swift
//  UniGrade
//
//  Created by Tom Woodley on 30/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import Foundation

struct Assessment {
    private(set) public var title: String
    
    init(title: String) {
        self.title = title
    }
}
