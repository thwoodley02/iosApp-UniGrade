//
//  YearOverviewView.swift
//  UniGrade
//
//  Created by Tom Woodley on 28/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class YearOverviewView: UIView {

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
        drawAllTargets()
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
    
    func drawTarget(percentage: Double, color: UIColor) {
        let widthOfSlider: Double = (Double(backimage.frame.size.width) - 40)
        let x: Double = ((percentage/100)*widthOfSlider) + 12
        
        let imageView = UIImageView(image: UIImage(named:"pin-1.png")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))

        imageView.tintColor = color
        imageView.frame = CGRect(x: CGFloat(x), y: 124, width: 15, height: 15)
        backimage.addSubview(imageView)
    }
    
    func drawAllTargets() {
        if let targets = DataService.instance.getUser().targets {
            for target in targets {
                drawTarget(percentage: Double(target), color: DataService.instance.getUser().getColorFromPercentage(percentage: target))
            }
        }
    }
    
    

    


}
