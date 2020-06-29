//
//  YearPageVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 28/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class YearPageVC: UIViewController {
    @IBOutlet weak var yearOverviewView: YearOverviewView!
    
    var year: Year!

    override func viewDidLoad() {
        super.viewDidLoad()
        yearOverviewView.updateViews(year: year)
        //yearOverviewView.updateViews(year: year)
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func setYear(year: Year) {
        self.year = year
    }
    
}
