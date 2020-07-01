//
//  AddYearVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 27/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class AddYearVC: UIViewController {
    
    @IBOutlet weak var overallTitleLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UITextField!
    @IBOutlet weak var creditsLbl: UITextField!
    @IBOutlet weak var percentageLbl: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var thisView: UIView!
    
    @IBOutlet weak var titleErrorLbl: UILabel!
    @IBOutlet weak var creditsErrorLbl: UILabel!
    @IBOutlet weak var percentageErrorLbl: UILabel!
    
    var onSubmit: ((_ data: Year) -> ())?
    var onUpdate: ((_ data: Year) -> ())?
    
    var isNew: Bool = true
    var year: Year?

    override func viewDidLoad() {
        super.viewDidLoad()
        if !isNew {
            overallTitleLbl.text = "Edit Year"
            if let y = year as? Year {
                titleLbl.text = y.title
                creditsLbl.text = "\(y.credits)"
                percentageLbl.text = "\(y.weight)"
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func setNew(year: Year) {
        self.isNew = false
        self.year = year
    }
        
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        let check1 = checkTitle(title: titleLbl.text ?? "Error")
        var oldid: Int64
        var oldYearOverview: Overview?
        var oldModules: [Module]?
        if !isNew {
            oldid = year!.id
            oldYearOverview = year!.getOverview()
            oldModules = year!.modules
        } else {
            oldid = Date().currentTimeMillis()
            oldYearOverview = nil
            oldModules = nil
        }
        let check2 = checkCredits(credits: creditsLbl.text ?? "Error")
        let check3 = checkWeight(weight: percentageLbl.text ?? "Error")
        if  check1 && check2 && check3 {
            let year = Year(id: oldid, title: titleLbl.text!, credits: Int(creditsLbl.text!)!, weight: Double(percentageLbl.text!)!, yearoverview: oldYearOverview, modules: oldModules)
            if isNew {
                onSubmit?(year)
            } else {
                onUpdate?(year)
            }
            dismiss(animated: true)
        }
    }
    
    func checkTitle(title: String) -> Bool {
        if let num = Int(title) {
            if let years = DataService.instance.getUser().years {
                if !isNew {
                    DataService.instance.getUser().removeTitleFromYear(year: year!)
                }
                
                var alreadyExists = false
                for year in years {
                    if title == year.title {
                        alreadyExists = true
                        titleErrorLbl.text = "Must be a unique year name"
                    }
                }
                if !alreadyExists {
                    titleErrorLbl.isHidden = true
                    return true
                }
            } else {
                titleErrorLbl.isHidden = true
                return true
            }
        } else {
            titleErrorLbl.text = "Must be a whole number"
        }
        titleErrorLbl.isHidden = false
        return false
    }
    
    func checkCredits(credits: String) -> Bool {
        if Int(credits) != nil {
            creditsErrorLbl.isHidden = true
            return true
        } else {
            creditsErrorLbl.text = "Must be a whole number of credits"
        }
        creditsErrorLbl.isHidden = false
        return false
    }
    
    func checkWeight(weight: String) -> Bool {
        if let num = Double(weight) {
            if let years = DataService.instance.getUser().years {
                var weightLeft: Double = 100
                if !isNew {
                    weightLeft += year!.weight
                }
                for year in years {
                    weightLeft -= year.weight
                }
                if num <= weightLeft {
                    percentageErrorLbl.isHidden = true
                    return true
                } else {
                    percentageErrorLbl.text = "Must be less than or equal to \(weightLeft)%"
                }
            } else {
                percentageErrorLbl.isHidden = true
                return true
            }
        } else {
            percentageErrorLbl.text = "You must enter a number"
        }
        percentageErrorLbl.isHidden = false
        return false
    }
    

}
