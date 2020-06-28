//
//  AddYearVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 27/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class AddYearVC: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(AddYearVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddYearVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
    guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
       // if keyboard size is not available for some reason, dont do anything
       return
    }
        thisView.frame.origin.y = self.view.frame.size.height - ( thisView.frame.size.height + keyboardSize.height)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
        thisView.frame.origin.y = (self.view.frame.size.height/2) - (thisView.frame.size.height/2)
    }
        
    
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        print("Reached")
        dismiss(animated: true)
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        let check1 = checkTitle(title: titleLbl.text ?? "Error")
        let check2 = checkCredits(credits: creditsLbl.text ?? "Error")
        let check3 = checkWeight(weight: percentageLbl.text ?? "Error")
        if  check1 && check2 && check3 {
            let year = Year(title: titleLbl.text!, credits: Int(creditsLbl.text!)!, weight: Double(percentageLbl.text!)!, yearoverview: nil)
            onSubmit?(year)
            dismiss(animated: true)
        }
    }
    
    func checkTitle(title: String) -> Bool {
        if let num = Int(title) {
            if let years = DataService.instance.getUser().years {
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
        if let num = Int(credits) {
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
