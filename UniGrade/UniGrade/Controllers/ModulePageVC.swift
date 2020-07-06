//
//  ModulePageVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 01/07/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

/*

class ModulePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var overviewView: OverviewView!
    @IBOutlet weak var titlePageLbl: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var module: Module!
    var year: Year!
    var updatePreviousView: ((_ data: Module) -> ())?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return DataService.instance.getUser().targets?.count ?? 0
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return module.assessments?.count ?? 0
        } else {
            return 0
        }
    }
    /*
    
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AssessmentsCell") as? AssessmentsCell {
                cell.updateViews(assesment: module.assessments![indexPath.row])
                return cell
            } else {
                return AssessmentsCell()
            }
        } else {
            return AssessmentsCell()
        }
        
    }
 */
    
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
        //tableView.dataSource = self
        overviewView.updateViews(overview: module)
        titlePageLbl.text = module.title
        backButton.tintColor = accentColour
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TOPencilModuleSegue {
            if let popup = segue.destination as? PencilEditVC {
                popup.setIsYear(isYear: false)
                popup.setModule(module: self.module)
                popup.onDeleteModule = moduleDeleted
                popup.setYear(year: year)
                popup.onUpdateModule = updateModule(_:)
            }
        } 
    }
    
    func moduleDeleted(_ data: Module) -> () {
        self.dismiss(animated: true)
        self.dismiss(animated: true)
        //updatePreviousView?(dat./a)
    }
    
    func updateModule(_ data: Module) -> () {
        loadData()
        tableView.reloadData()
    }

}

 */
