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
        updateView()
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
        
    }
    
    /*
    
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
 */
    
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
            if let popup = segue.destination as? YearPageVC {                
                assert(sender as? Year != nil)
                popup.setYear(year: sender as! Year)
                popup.updatePreviousView = updateView
            }
        }
    }
    
    
    func targetsReturned(_ targets: [Int]) -> () {
        overviewView.targetsChanged(targets: targets)
        yearTableView.reloadData()
    }
    
    func yearAdded(_ data: Year) -> () {
        DataService.instance.getUser().addYear(year: data)
        yearTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let years = DataService.instance.getUser().years {
            let thisYear = years[indexPath.row]
            performSegue(withIdentifier: "yearPageSegue", sender: thisYear)
        }
    }
    
    func updateView() {
        DataService.instance.getUser().updateUser()
        yearTableView.reloadData()
        if let overview = DataService.instance.getUser().grandoverall {
            overviewView.updateViews(overview: overview)
        }
    }
    
    
}

