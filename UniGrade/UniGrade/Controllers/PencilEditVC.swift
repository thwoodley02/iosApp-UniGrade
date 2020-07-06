//
//  YearPencilVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 30/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class PencilEditVC: UIViewController {
    
    @IBOutlet weak var bigView: UIButton!
    @IBOutlet weak var smallView: UIView!
    
    var isYear: Bool = true
    var year: Year?
    var module: Module?
    
    var onDeleteYear: (() -> ())?
    var onUpdateYear: ((_ data: Year) -> ())?
    
    var onDeleteModule: ((_ data: Module) -> ())?
    var onUpdateModule: ((_ data: Module) -> ())?
    
    func setYear(year: Year) {
        self.year = year
    }
    
    func setModule(module: Module) {
        self.module = module
    }
    
    func setIsYear(isYear: Bool) {
        self.isYear = isYear
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        smallView.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bigViewPressed(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func editPressed(_ sender: Any) {
        
    }
    @IBAction func deletePressed(_ sender: Any) {
        var alertText: String
        if isYear {
            alertText = "Are you sure you want to delete this year?"
        } else
        {
            alertText = "Are you sure you want to delete this module?"
        }
        let alert = UIAlertController(title: alertText, message: "This action cannot be undone", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
            self.deleteCancelled()
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {(action) in
            self.deleteConfirm()
        }))
        self.present(alert, animated: true)
    }
    
    func deleteCancelled(){
        self.dismiss(animated: true)
    }
    
    func deleteConfirm() {
        
        if isYear {
            DataService.instance.getUser().deleteYear(year: year!)
            onDeleteYear?()
        } else {
            //Should delete module here
            onDeleteModule?(module!)
        }
        self.dismiss(animated: true)
    }
    
    func updateYear(_ data: Year) -> () {
        if isYear {
            DataService.instance.getUser().updateYear(year: data)
            onUpdateYear?(data)
        } else {
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TOEditYearSegue {
            if let popup = segue.destination as? AddYearVC {
                popup.setNew(year: year!)
                popup.onUpdate = updateYear
            }
        } else if segue.identifier == TOEditModuleSegue {
            if let popup = segue.destination as? AddModuleVC {
                popup.isNew = false
                popup.thisModule = module!
                popup.setYear(year: year!)
            }
        }
    }
    
    
}
