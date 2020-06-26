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
        let model = Overview(average: 74.5, achieved: 2.345, complete: 4.564, target: 75.3)
        
        overviewView.updateViews(overview: model)
        overviewView.layer.cornerRadius = 10.0
    }


}

