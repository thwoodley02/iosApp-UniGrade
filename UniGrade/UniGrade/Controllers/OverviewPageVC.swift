//
//  ViewController.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class OverviewPageVC: UIViewController {
    @IBOutlet weak var overviewView: OverviewView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let year1 = Year(numtest: 1)
        let year2 = Year(numtest: 2)
        let year3 = Year(numtest: 3)
        let years = [year1, year2, year3]
        let model = Overview(average: 75, achieved: 66, complete: 56, target: 65, Years: years)
        
        overviewView.updateViews(overview: model)
        overviewView.layer.cornerRadius = 10.0
    }


}

