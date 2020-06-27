//
//  ViewController.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class OverviewPageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var overviewView: OverviewView!
    @IBOutlet weak var yearTableView: UITableView!
    @IBOutlet weak var targetImage: UIImageView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let years = DataService.instance.getUser().years {
            return years.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "yearCell") as? YearsOverviewCell {
            if let years = DataService.instance.getUser().years {
                cell.updateViews(year: years[indexPath.row])
            }
            
            
            
            return cell
        } else {
            return YearsOverviewCell()
        }
    }
    
    
    
    override func viewDidLoad() {
        DataService.instance.initalise()
        super.viewDidLoad()
        overviewView.updateViews(overview: DataService.instance.getUser().grandoverall!)
        yearTableView.dataSource = self
        yearTableView.delegate = self
        yearTableView.rowHeight = 150
        
        
        //Layout Edits
        overviewView.layer.cornerRadius = 10.0
        targetImage.layer.cornerRadius = 28.0
        
        targetImage.isUserInteractionEnabled = true
        targetImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        
        //Drawing Targets
        /*
        let imageName = "pin.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
 */
        if let targets = DataService.instance.getUser().targets {
            for target in targets {
            drawTarget(percentage: CGFloat(target))
        }
        
        }
    }
    
    func drawTarget(percentage: CGFloat) {
        let widthOfSlider: CGFloat = ((overviewView.bounds.size.width) - 16)
        let x: CGFloat = ((percentage/100)*widthOfSlider)
        
        let imageView = UIImageView(image: UIImage(named:"pin-1.png")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))
        
        var color = UIColor.init(hue: (((93.0-17.0)*(percentage/100)) + 17.0)/360, saturation: 97.0/100.0, brightness: 77.0/100.0, alpha: 1.0)
        imageView.tintColor = color
        imageView.frame = CGRect(x: x, y: 100, width: 15, height: 15)
        overviewView.addSubview(imageView)
    }
    
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
    print("image tapped")
    }


}

