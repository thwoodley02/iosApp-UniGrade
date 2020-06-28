//
//  PickTargetsVC.swift
//  UniGrade
//
//  Created by Tom Woodley on 27/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class PickTargetsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var targetTable: UITableView!
    
    var targets: [Int] = []
    var onDone: ((_ targets: [Int]) -> ())?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targets.count
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "targetCell") as? TargetCell {
            cell.updateViews(target: targets[indexPath.row])
            return cell
        } else {
            return TargetCell()
        }
    }
    
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        onDone?(targets)
        dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        DataService.instance.initalise()
        super.viewDidLoad()
        targetTable.dataSource = self
        targetTable.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func removeTarget(target: Int) {
        let index = targets.firstIndex(of: target)
        targets.remove(at: index!)
        targetTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newTargetSegue" {
            let popup = segue.destination as! AddTargetVC
            popup.onAdd = targetAdded
        }
    }
    
    func targetAdded(_ data: Int) -> () {
        
        targets = DataService.instance.insertIntinIntList(newvalue: data, oldInts: targets)
        targetTable.reloadData()
    }

}
