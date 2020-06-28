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
    @IBOutlet weak var targetButton: UIButton!
    @IBOutlet weak var slider: UIProgressView!
    @IBOutlet weak var pageView: UIView!
    
    var targetImages: [UIImageView] = []
    
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
        if let overview = DataService.instance.getUser().grandoverall {
            overviewView.updateViews(overview: overview)
        }
        yearTableView.dataSource = self
        yearTableView.delegate = self
        yearTableView.rowHeight = 170
        
        
        //Layout Edits
        overviewView.layer.cornerRadius = 10.0
        targetButton.layer.cornerRadius = 20.0
        
        //targetButton.isUserInteractionEnabled = true
        //targetImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        
        //Drawing Targets
        
        drawAllTargets()
        
    }
    
    
    func drawTarget(percentage: Double, color: UIColor) {
        let widthOfSlider: Double = Double(overviewView.frame.size.width) - 16
        let x: Double = (widthOfSlider*(percentage/100))
        
        let imageView = UIImageView(image: UIImage(named:"pin-1.png")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate))

        imageView.tintColor = color
        imageView.frame = CGRect(x: CGFloat(x), y: 100, width: 15, height: 15)
        targetImages.append(imageView)
        overviewView.addSubview(imageView)
    }
    
    func drawAllTargets() {
        if let targets = DataService.instance.getUser().targets {
            for target in targets {
                drawTarget(percentage: Double(target), color: DataService.instance.getUser().getColorFromPercentage(percentage: target))
            }
        }
    }
    
    /*
    @objc private func imageTapped(_ recognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "targetSegue", sender: self)
    }
 */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "targetSegue" {
            let popup = segue.destination as! PickTargetsVC
            if let targets = DataService.instance.getUser().targets {
                popup.targets = targets
            } else {
                popup.targets = []
            }
            popup.onDone = targetsReturned
        } else if segue.identifier == "addYearSegue" {
            let popup = segue.destination as! AddYearVC
            popup.onSubmit = yearAdded
        } else if segue.identifier == "yearPageSegue" {
            //Year Page
        }
    }
    
    
    func targetsReturned(_ targets: [Int]) -> () {
        for images in targetImages {
            images.removeFromSuperview()
        }
        DataService.instance.getUser().setTargets(targets: targets)
        drawAllTargets()
    }
    
    func yearAdded(_ data: Year) -> () {
        DataService.instance.getUser().addYear(year: data)
        yearTableView.reloadData()
    }

    
    
}

