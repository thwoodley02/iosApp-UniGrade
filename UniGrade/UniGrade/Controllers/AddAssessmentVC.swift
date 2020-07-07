//
//  AddAssessmentVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 07/07/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class AddAssessmentVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var wholeModuleSwitch: UISwitch!
    @IBOutlet weak var assessmentTitleField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var markField: UITextField!
    
    @IBOutlet weak var titleErrorLbl: UILabel!
    @IBOutlet weak var weightErrorLbl: UILabel!
    @IBOutlet weak var markErrorLbl: UILabel!
    @IBOutlet weak var placeholderSwitch: UISwitch!
    
    var thisModule: Module!
    var thisAssessment: Assessment?
    var isNew: Bool!
    
    var onSubmit: ((_ data: Assessment) -> ())?
    var onUpdate: (() -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        var oldid: Int64
        
        if !isNew {
            oldid = thisModule!.id
        } else {
            oldid = Date().currentTimeMillis()
        }
        
        let check1 = checkTitle(title: assessmentTitleField.text)
        let check2 = checkWeight(Weight: weightField.text ?? "error")
        let check3 = checkMark(Mark: markField.text ?? "error")
        
        if check1 && check2 && check3 {
            let assessment = Assessment(id: oldid, title: assessmentTitleField.text!, isPlaceholder: placeholderSwitch.isOn, weight: Double(weightField.text!) ?? 0, mark: Double(markField.text!) ?? 0)
            
            if isNew {
                onSubmit?(assessment)
            } else {
                thisAssessment = assessment
                onUpdate?()
            }
            dismiss(animated: true)
        }
    }
    
    func checkTitle(title: String?) -> Bool {
        if let str = title {
            if str != "" {
                titleErrorLbl.isHidden = true
                return true
            }
            else {
                titleErrorLbl.text = "You must have a title"
            }
        }
        return false
    }
    
    func checkWeight(Weight: String) -> Bool {
        if let weight: Double = Double(Weight) {
            if let asses = thisModule.assessments {
                var percentageLeft: Double = 100
                if !isNew {
                    percentageLeft += thisAssessment!.weight
                }
                for ass in asses {
                    percentageLeft -= ass.weight
                }
                if weight <= percentageLeft {
                    weightErrorLbl.isHidden = true
                    return true
                } else {
                    weightErrorLbl.text = "Must be less than or equal to \(percentageLeft)%"
                }
            } else {
                weightErrorLbl.isHidden = true
                return true
            }
        } else {
            weightErrorLbl.text = "Must enter a value"
        }
        weightErrorLbl.isHidden = false
        return false
    }
    
    func checkMark(Mark: String) -> Bool {
        if let mark: Double = Double(Mark) {
            if mark <= 100 {
                if mark >= 0 {
                    markErrorLbl.isHidden = true
                    return true
                } else {
                    markErrorLbl.text = "Your mark can't be less than 0%"
                }
            } else {
                markErrorLbl.text = "Your mark can't be greater than 100%"
            }
        } else {
            markErrorLbl.text = "You must enter a number"
        }
        markErrorLbl.isHidden = false
        return false
    }
    
    
}
