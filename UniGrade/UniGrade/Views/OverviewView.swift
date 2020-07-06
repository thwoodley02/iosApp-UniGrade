//
//  OverviewView.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class OverviewView: UIView {

    @IBOutlet weak var averageLbl: UILabel?
    @IBOutlet weak var achievedLbl: UILabel!
    @IBOutlet weak var completeLbl: UILabel!
    @IBOutlet weak var averageSlider: UIProgressView!
    @IBOutlet weak var creditsLbl: UILabel?
    @IBOutlet weak var weightLbl: UILabel?
    @IBOutlet weak var titleLbl: UILabel?
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var forwardArrow: UIImageView?
    @IBOutlet weak var forwardButton: UIButton?
    
    var targetImages: [UIImageView] = []
    var y: Int = 124
    var cellWidth: CGFloat!

    
    
    public func updateViews(overview: Any) {
        //self.roundCorners(corners: .allCorners, radius: 10)
        //backImage.roundCorners(corners: .allCorners, radius: 10)

        backImage.layer.cornerRadius = 10
        averageSlider.progressTintColor = accentColour
        if let arrow = forwardArrow {
            arrow.tintColor = accentColour
        }
        if let arrow = forwardButton {
            arrow.tintColor = accentColour
        }
        //backImage.layer.borderWidth = 1.0
        //backImage.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if let thisOverview = overview as? Overview { //Overview Type
            y = 100
            averageLbl!.text = thisOverview.getAverageStr()
            achievedLbl.text = thisOverview.getAchievedStr()
            completeLbl.text = thisOverview.getCompleteStr()
            averageSlider.progress = Float(thisOverview.average/100)
        } else if let thisYear = overview as? Year { //Year Type
            y = 124
            averageLbl!.text = thisYear.getAverageStr()
            achievedLbl.text = thisYear.getAchievedStr()
            completeLbl.text = thisYear.getCompleteStr()
            averageSlider.progress = Float(thisYear.getAverage()/100)
            creditsLbl!.text = thisYear.getCreditsStr()
            weightLbl!.text = thisYear.getWeightStr()
            titleLbl!.text = thisYear.getTitleStr()
        } else if let thisModule = overview as? Module { //Module Type
            titleLbl!.text = thisModule.getTitleStr()
            creditsLbl!.text = thisModule.getCreditsStr()
            averageLbl!.text = thisModule.getAverageStr()
            achievedLbl.text = thisModule.getAchievedStr()
            completeLbl.text = thisModule.getCompleteStr()
            averageSlider.progress = Float(thisModule.getAverage()/100)
        } else if let thisAssessment = overview as? Assessment {
            y = 95
            titleLbl!.text = thisAssessment.title
            achievedLbl.text = "\(Int(round(thisAssessment.mark)))%"
            completeLbl.text = "\(Int(round(thisAssessment.weight)))%"
            averageSlider.progress = Float(thisAssessment.mark/100)
        }
        //deleteOldImages()
        //drawAllTargets(y: y)
        
    }
    
    func redrawTargets() {
        //deleteOldImages()
        //drawAllTargets(y: y)
    }
    
    func drawTarget(percentage: Double, color: UIColor, y: Int) {
        let widthOfSlider: Double = (Double(cellWidth) - 40)
        let x: Double = ((percentage/100)*widthOfSlider) + 12
        
        let imageView = UIImageView(image: UIImage(named:"pin-1.png")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))

        imageView.tintColor = color
        imageView.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: 15, height: 15)
        targetImages.append(imageView)
        backImage.addSubview(imageView)
    }
    
    func drawAllTargets(y: Int) {
        if let targets = DataService.instance.getUser().targets {
            for target in targets {
                drawTarget(percentage: Double(target), color: DataService.instance.getUser().getColorFromPercentage(percentage: target), y: y)
            }
        }

    }
    
    func targetsChanged(targets: [Int]) {
        //deleteOldImages()
        //DataService.instance.getUser().setTargets(targets: targets)
        //drawAllTargets(y: y)
    }
    
    func deleteOldImages() {
        for images in targetImages {
            images.removeFromSuperview()
        }
    }
    
    
    
    

}
