//
//  AddTargetVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 27/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class AddTargetVC: UIViewController {
    
    @IBOutlet weak var targetText: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var onAdd: ((_ data: Int) -> ())?
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let text = targetText.text
        var reply: String = ""
        if let num = Double(text!) {
            if let numInt = Int(text!) {
                if numInt <= 100 && numInt >= 0 {
                    reply = "Perfect"
                    onAdd?(numInt)
                    dismiss(animated: true)
                } else {
                    reply = "Your target must be between 0 and 100!"
                }
            } else {
                reply = "Your target must be a whole number!"
            }
        } else {
            reply = "You don't seem to have entered a number!"
        }
        if reply != "Perfect" {
            let alert = UIAlertController(title: "Oh no!", message: reply, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            targetText.text = ""
        }
        
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

    

}
