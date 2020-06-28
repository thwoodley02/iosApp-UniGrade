//
//  TargetCell.swift
//  UniGrade
//
//  Created by Tom Woodley on 27/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class TargetCell: UITableViewCell {
    @IBOutlet weak var controller: UIViewController!
    @IBOutlet var targetImage: UIImageView!
    @IBOutlet weak var targetLbl: UILabel!
    @IBOutlet weak var binImage: UIButton!
    @IBOutlet weak var targetCell: UIView!
    
    public var tar: Int = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(target: Int)
    {
        tar = target
        let user = DataService.instance.getUser()
        
        /*
        let imageView = UIImageView(image: UIImage(named:"pin-1.png")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
        imageView.tintColor = color
        imageView.frame = CGRect(x: CGFloat(x), y: 100, width: 15, height: 15)
        targetImages.append(imageView)
        overviewView.addSubview(imageView)
        */
        let targetImageView = UIImageView(image: UIImage(named: "location-target")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
        targetImageView.tintColor = user.getColorFromPercentage(percentage: target)
        targetImageView.frame = CGRect(x: 8, y: 7, width: 27, height: 27)
        targetCell.addSubview(targetImageView)
        
        targetLbl.text = user.grandoverall?.roundToPercentage(percentage: Double(target))
    }
    @IBAction func binImagPressed(_ sender: Any) {
        if let cont = controller as? PickTargetsVC {
            cont.removeTarget(target: tar)
        }
    }
    
}
