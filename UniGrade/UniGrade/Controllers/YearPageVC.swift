//
//  YearPageVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 28/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class YearPageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var overviewView: OverviewView!
    @IBOutlet weak var titlePageLbl: UILabel!
    
    var year: Year!
    
    var updatePreviousView: (() -> ())?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return DataService.instance.getUser().targets?.count ?? 0
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return year.modules?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "targetTitleCell") as? TargetTitleCell {
                return cell
            } else {
                return TargetTitleCell()
            }
        } else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "targetContentCell") as? TargetContentCell {
                cell.updateViews(thisOverview: year.getOverview(), rowNum: indexPath.row)
                return cell
            } else {
                return TargetContentCell()
            }
        } else if indexPath.section == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "moduleTitleCell") as? ModuleTitleCell {
                return cell
            } else {
                return ModuleTitleCell()
            }
        } else if indexPath.section == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "moduleContentCell") as? ModuleContentCell {
                cell.updateViews(module: year.modules![indexPath.row])
                return cell
            } else {
                return ModuleContentCell()
            }
        } else {
            return ModuleContentCell()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        tableView.delegate = self
        tableView.dataSource = self
        overviewView.updateViews(overview: year)
        titlePageLbl.text = year.getTitleStr()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func setYear(year: Year) {
        self.year = year
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pencilSegue" {
            if let popup = segue.destination as? YearPencilVC {
                popup.setYear(year: self.year)
                popup.onDelete = yearDeleted
                popup.onUpdate = yearUpdated
            }
        } else if segue.identifier == "addModuleSegue" {
            if let popup = segue.destination as? AddModuleVC {
                popup.setYear(year: self.year)
                popup.onSubmit = newModule(_:)
            }
        } else if segue.identifier == "modulePageSegue" {
            if let popup = segue.destination as? ModulePageVC {
                assert(sender as? Module != nil)
                popup.setModule(module: sender as! Module)
            }
        }
    }
    
    func yearDeleted() -> () {
        self.dismiss(animated: true)
        self.dismiss(animated: true)
        updatePreviousView?()
    }
    
    func yearUpdated(_ data: Year) -> () {
        self.year = data
        loadData()
        updatePreviousView?()
        
        //Should reload data on overview
    }
    
    func newModule(_ data: Module) -> () {
        year.addModule(module: data)
        loadData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let thisModule = year.modules![indexPath.row] //, sender: thisModule
            performSegue(withIdentifier: "modulePageSegue", sender: thisModule)
        }
        
    }
}
