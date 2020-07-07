//
//  ModulePageVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 01/07/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit



class ModulePageVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var overviewView: OverviewView!
    @IBOutlet weak var titlePageLbl: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var module: Module!
    var year: Year!
    var updatePreviousView: ((_ data: Module) -> ())?
    var updateBackwards: (() -> ())?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return DataService.instance.getUser().targets?.count ?? 0
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return module?.assessments?.count ?? 0
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
                cell.updateViews(thisOverview: module.moduleOverview, rowNum: indexPath.row)
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
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ASsessmentsCell, for: indexPath) as? AssessmentsCell {
                cell.updateViews(assesment: module.assessments![indexPath.row])
                return cell
            } else {
                return AssessmentsCell()
            }
        } else {
            return AssessmentsCell()
        }
    }
    
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
            return CGSize(width: width, height: 140)
        } else {
            return CGSize(width: width, height: 140)
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
        collectionView.delegate = self
        collectionView.dataSource = self
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
        } else if segue.identifier == TOAddAssesSegue {
            if let popup = segue.destination as? AddAssessmentVC {
                popup.thisModule = module
                popup.isNew = true
                popup.onSubmit = newAssessment(_:)
            }
        }
    }
    
    func moduleDeleted(_ data: Module) -> () {
        self.dismiss(animated: true)
        self.dismiss(animated: true)
        //updatePreviousView?(dat./a)
    }
    
    func updateModule(_ data: Module) -> () {
        year = DataService.instance.getUser().getThisYear(year: year)
        module = year.getThisModule(module: module)
        loadData()
        collectionView.reloadData()
        
    }
    
    func newAssessment(_ data: Assessment) -> () {
        module.addNewAssessment(assessment: data)
        DataService.instance.getUser().updateUser()
        
        year = DataService.instance.getUser().getThisYear(year: year)
        module = year.getThisModule(module: module)
        loadData()
        collectionView.reloadData()
        
        updateBackwards?()
    }

}

 
