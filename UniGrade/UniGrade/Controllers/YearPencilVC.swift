//
//  YearPencilVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 30/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class YearPencilVC: UIViewController {
    
    @IBOutlet weak var bigView: UIButton!
    @IBOutlet weak var smallView: UIView!
    
    var year: Year?
    
    var onDelete: (() -> ())?
    var onUpdate: ((_ data: Year) -> ())?
    
    func setYear(year: Year) {
        self.year = year
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        smallView.roundCorners(corners: .allCorners, radius: 10)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func bigViewPressed(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func editPressed(_ sender: Any) {
        
    }
    @IBAction func deletePressed(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to delete this year?", message: "This action cannot be undone", preferredStyle: .alert)
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
        DataService.instance.getUser().deleteYear(year: year!)
        onDelete?()
        self.dismiss(animated: true)
    }
    
    func updateYear(_ data: Year) -> () {
        DataService.instance.getUser().updateYear(year: data)
        onUpdate?(data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editYearSegue" {
            if let popup = segue.destination as? AddYearVC {
                popup.setNew(year: year!)
                popup.onUpdate = updateYear
            }
        }
    }
    
    
}
