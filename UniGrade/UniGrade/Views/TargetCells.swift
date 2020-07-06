//
//  TargetTitleCell.swift
//  UniGrade
//
//  Created by Tom Woodley on 03/07/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class TargetTitleCell: UICollectionViewCell {
    @IBOutlet weak var titleCellView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        //titleCellView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        titleCellView.clipsToBounds = true
        titleCellView.layer.cornerRadius = 10
        titleCellView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}

class TargetContentCell: UICollectionViewCell {
    
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var remainingAverageLbl: UILabel!
    @IBOutlet weak var targetCell: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func updateViews(thisOverview: Overview?, rowNum: Int) {
        if let targets = DataService.instance.getUser().targets {
            let thisTarget: Int = targets[rowNum]
            
            //Draw the coloured target
            let targetImageView = UIImageView(image: UIImage(named: "location-target")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
            targetImageView.tintColor = DataService.instance.getUser().getColorFromPercentage(percentage: thisTarget)
            targetImageView.frame = CGRect(x: 8, y: 7, width: 27, height: 27)
            targetCell.addSubview(targetImageView)
            
            //check if bottom corners should be rounded
            if rowNum == (targets.count - 1) {
                targetCell.clipsToBounds = true
                targetCell.layer.cornerRadius = 10
                targetCell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }
            targetLbl.text = "\(thisTarget)%"
            if let overview = thisOverview {
                
                if overview.complete != 0 {
                    let remainingAverage = (Double(thisTarget) - overview.achieved) / (100.0 - overview.complete)
                    if remainingAverage > 1.0 {
                        //Would need to get hgiher than possible so should produce a cross
                    } else if remainingAverage < 0.0 {
                        //Already achieved - should be a tick
                    } else {
                        //remainign average between 0 and 100
                        let roundedRemain: Double = Double(Int(round(remainingAverage*1000)))/10
                        remainingAverageLbl.text = "\(roundedRemain)%"
                    }
                } else {
                    //Whole module finished should either tick or cross
                    
                }
            } else {
                // Doesn't have an overview so should fill with targets
                remainingAverageLbl.text = "\(thisTarget).0%"
            }
        }
        
    }

}
