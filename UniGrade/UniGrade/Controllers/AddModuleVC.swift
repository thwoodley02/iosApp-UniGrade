//
//  AddModuleVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 01/07/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class AddModuleVC: UIViewController {
    
    @IBOutlet weak var viewTitle: UILabel!
    
    @IBOutlet weak var moduleNameField: UITextField!
    @IBOutlet weak var creditsField: UITextField!
    
    @IBOutlet weak var moduleNameError: UILabel!
    @IBOutlet weak var creditsError: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var thisView: UIView!
    
    var isNew: Bool = true
    var thisModule: Module?
    var thisYear: Year!
    
    var onSubmit: ((_ data: Module) -> ())?
    var onUpdate: ((_ data: Module) -> ())?
    
    func setYear(year: Year) {
        self.thisYear = year
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        var oldid: Int64
        var oldModuleOverview: Overview?
        var oldAsses: [Assessment]?
        let check1 = checkCredits(credits: creditsField.text ?? "Error")
        
        if !isNew {
            oldid = thisModule!.id
            oldModuleOverview = thisModule!.moduleOverview
            oldAsses = thisModule!.assessments
        } else {
            oldid = Date().currentTimeMillis()
            oldModuleOverview = nil
            oldAsses = nil
        }
        if let title = moduleNameField.text {
            moduleNameError.isHidden = true
            if title != "" {
                if check1 {
                    let module = Module(id: oldid, title: title, credits: Int(creditsField.text!) ?? 0, moduleOverview: oldModuleOverview, assessments: oldAsses)
                    if isNew {
                        onSubmit?(module)
                    } else {
                        onUpdate?(module)
                    }
                    self.dismiss(animated: true)
                } else {
                    
                }
            } else {
                moduleNameError.text = "There's no Module Title"
                moduleNameError.isHidden = false
            }
        } else {
            moduleNameError.text = "There's no Module Title"
            moduleNameError.isHidden = false
        }
        
    }
    
    func checkCredits(credits: String) -> Bool {
        if let num = Int(credits) {
            if let mods = thisYear.modules {
                var creditsLeft: Int = thisYear.credits
                if !isNew {
                    creditsLeft += thisModule!.credits
                }
                for mod in mods {
                    creditsLeft -= mod.credits
                }
                if num <= creditsLeft {
                    creditsError.isHidden = true
                    return true
                } else {
                    creditsError.text = "Must be less than or equal to \(creditsLeft)"
                }
            } else {
                creditsError.isHidden = true
                return true
            }
        } else {
            creditsError.text = "You must enter a whole number"
        }
        creditsError.isHidden = false
        return false
    }
    

}
