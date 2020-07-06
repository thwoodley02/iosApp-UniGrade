//
//  ViewController.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class OverviewPageVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var overviewView: OverviewView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var targetButton: UIButton!
    @IBOutlet weak var slider: UIProgressView!
    @IBOutlet weak var pageView: UIView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let years = DataService.instance.getUser().years {
            return years.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YEarCell, for: indexPath) as? YearsOverviewCell {
            if let years = DataService.instance.getUser().years {
                var width: CGFloat = 0
                if traitCollection.horizontalSizeClass == .regular {
                    width = (collectionView.bounds.size.width / 2) - 10
                } else {
                    width = collectionView.bounds.size.width
                }
                cell.updateViews(year: years[indexPath.row], cellWidth: width)
            }
            return cell
        } else {
            return YearsOverviewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 0
        if traitCollection.horizontalSizeClass == .regular {
            width = (collectionView.bounds.size.width / 2) - 10
        } else {
            width = collectionView.bounds.size.width
        }
        
        return CGSize(width: width, height: 155)
    }
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let years = DataService.instance.getUser().years {
            let thisYear = years[indexPath.row]
            performSegue(withIdentifier: TOYearPageSegue, sender: thisYear)
        }
    }
    
    
    
    override func viewDidLoad() {
        DataService.instance.initalise()
        super.viewDidLoad()
        updateView()
        if let overview = DataService.instance.getUser().grandoverall {
            overviewView.cellWidth = UIScreen.main.bounds.width - 20
            overviewView.updateViews(overview: overview)
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //Layout Edits
        targetButton.layer.cornerRadius = 20.0
        
    }
    
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        collectionView.layoutMarginsDidChange()
        collectionView.reloadData()
        overviewView.redrawTargets()
        if let overview = DataService.instance.getUser().grandoverall {
            overviewView.cellWidth = UIScreen.main.bounds.width - 20
            overviewView.updateViews(overview: overview)
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self,
        name: UIDevice.orientationDidChangeNotification,
        object: nil)
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TOTargetSegue {
            let popup = segue.destination as! PickTargetsVC
            if let targets = DataService.instance.getUser().targets {
                popup.targets = targets
            } else {
                popup.targets = []
            }
            popup.onDone = targetsReturned
        } else if segue.identifier == TOAddYearSegue {
            let popup = segue.destination as! AddYearVC
            popup.onSubmit = yearAdded
        } else if segue.identifier == TOYearPageSegue {
            if let popup = segue.destination as? YearPageVC {                
                assert(sender as? Year != nil)
                popup.setYear(year: sender as! Year)
                popup.updatePreviousView = updateView
            }
        }
    }
    
    
    func targetsReturned(_ targets: [Int]) -> () {
        overviewView.targetsChanged(targets: targets)
        collectionView.reloadData()
    }
    
    func yearAdded(_ data: Year) -> () {
        DataService.instance.getUser().addYear(year: data)
        collectionView.reloadData()
    }
    
    func updateView() {
        DataService.instance.getUser().updateUser()
        collectionView.reloadData()
        if let overview = DataService.instance.getUser().grandoverall {
            overviewView.updateViews(overview: overview)
        }
    }
    
    
}

