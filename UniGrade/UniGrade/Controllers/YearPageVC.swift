//
//  YearPageVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 28/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class YearPageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var overviewView: OverviewView!
    @IBOutlet weak var titlePageLbl: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var year: Year!
    
    var updatePreviousView: (() -> ())?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.size.width
        
        if indexPath.section == 0 {
            return CGSize(width: width, height: 92)
        } else if indexPath.section == 1 {
            return CGSize(width: width, height: 44)
        } else if indexPath.section == 2 {
            return CGSize(width: width, height: 106)
        } else if indexPath.section == 3 {
            if traitCollection.horizontalSizeClass == .regular {
                width = (collectionView.bounds.size.width / 2) - 10
            } else {
                width = collectionView.bounds.size.width
            }
            return CGSize(width: width, height: 155)
        } else {
            return CGSize(width: width, height: 158)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 0
        } else if section == 2 {
            return 0
        } else if section == 3 {
            return 10
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TArgetTitleCell, for: indexPath) as? TargetTitleCell {
                return cell
            } else {
                return TargetTitleCell()
            }
        } else if indexPath.section == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TArgetContentCell, for: indexPath) as? TargetContentCell {
                cell.updateViews(thisOverview: year.getOverview(), rowNum: indexPath.row)
                return cell
            } else {
                return TargetContentCell()
            }
        } else if indexPath.section == 2 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MOduleTitleCell, for: indexPath) as? ModuleTitleCell {
                return cell
            } else {
                return ModuleTitleCell()
            }
        } else if indexPath.section == 3 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MOduleContentCell, for: indexPath) as? ModuleContentCell {
                cell.updateViews(module: year.modules![indexPath.row])
                return cell
            } else {
                return ModuleContentCell()
            }
        } else {
            return ModuleContentCell()
        }
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        collectionView.dataSource = self
        collectionView.delegate = self
        overviewView.updateViews(overview: year)
        titlePageLbl.text = year.getTitleStr()
        backButton.tintColor = accentColour
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func setYear(year: Year) {
        self.year = year
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TOPencilYearSegue {
            if let popup = segue.destination as? PencilEditVC {
                popup.setYear(year: self.year)
                popup.onDeleteYear = yearDeleted
                popup.onUpdateYear = yearUpdated
            }
        } else if segue.identifier == TOAddModuleSegue {
            if let popup = segue.destination as? AddModuleVC {
                popup.setYear(year: self.year)
                popup.onSubmit = newModule(_:)
            }
        } /* else if segue.identifier == TOModulePageSegue {
            if let popup = segue.destination as? ModulePageVC {
                assert(sender as? Module != nil)
                popup.setModule(module: sender as! Module)
                popup.updatePreviousView = moduleDeleted(_:)
                popup.year = year
                
            }
        }
 */
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
        collectionView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 3 {
            let thisModule = year.modules![indexPath.row] //, sender: thisModule
            performSegue(withIdentifier: TOModulePageSegue, sender: thisModule)
        }
        
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        collectionView.layoutMarginsDidChange()
        collectionView.reloadData()
        overviewView.redrawTargets()
        loadData()
    }
    
    
    func moduleDeleted(_ data: Module) {
        year.deleteModule(module: data)
        print(year.modules!.count)
        year.updateOverview()
        loadData()
        collectionView.reloadData()
        updatePreviousView?()
    }
    
    func updateThisView() {
        year.updateOverview()
        loadData()
        collectionView.reloadData()
        updatePreviousView?()
    }
}
