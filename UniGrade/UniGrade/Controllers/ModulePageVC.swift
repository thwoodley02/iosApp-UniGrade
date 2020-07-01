//
//  ModulePageVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 01/07/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class ModulePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var overviewView: OverviewView!
    @IBOutlet weak var titlePageLbl: UILabel!
    
    var module: Module!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return DataService.instance.getUser().targets?.count ?? 0
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 0
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
                cell.updateViews(thisOverview: module.moduleOverview, rowNum: indexPath.row)
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AssessmentsCell") as? ModuleContentCell {
                //cell.updateViews(module: year.modules![indexPath.row])
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
    
    func setModule(module: Module) {
        self.module = module
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func loadData() {
        tableView.delegate = self
        tableView.dataSource = self
        overviewView.updateViews(overview: module)
        titlePageLbl.text = module.title
    }

}
