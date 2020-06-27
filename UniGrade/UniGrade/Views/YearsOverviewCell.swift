//
//  YearsOverviewCell.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class YearsOverviewCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var creditsYearLbl: UILabel!
    @IBOutlet weak var weightYearLbl: UILabel!
    @IBOutlet weak var averageYearLbl: UILabel!
    @IBOutlet weak var achievedYearLbl: UILabel!
    @IBOutlet weak var completeYearLbl: UILabel!
    @IBOutlet weak var averageProgressYearLbl: UIProgressView!
    @IBOutlet weak var backimage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func updateViews(year: Year) {
        titleLbl.text = year.getTitleStr()
        creditsYearLbl.text = year.getCreditsStr()
        weightYearLbl.text = year.getWeightStr()
        averageYearLbl.text = year.getAverageStr()
        achievedYearLbl.text = year.getAchievedStr()
        completeYearLbl.text = year.getCompleteStr()
        averageProgressYearLbl.progress = Float(year.getAverage()/100)
        backimage.layer.cornerRadius = 10.0
        
    }
    

    

}
