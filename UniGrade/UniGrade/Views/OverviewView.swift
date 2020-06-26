//
//  OverviewView.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class OverviewView: UIView {

    @IBOutlet weak var averageLbl: UILabel!
    @IBOutlet weak var achievedLbl: UILabel!
    @IBOutlet weak var completeLbl: UILabel!
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var averageSlider: UIProgressView!
    
    public func updateViews(overview: Overview) {
        averageLbl.text = overview.getAverageStr()
        achievedLbl.text = overview.getAchievedStr()
        completeLbl.text = overview.getCompleteStr()
        targetLbl.text = overview.getTargetStr()
        averageSlider.progress = Float(overview.average/100)
    }
    
    
    
    

}
