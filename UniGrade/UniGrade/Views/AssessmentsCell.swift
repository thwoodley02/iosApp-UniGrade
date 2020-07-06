//
//  AssessmentsCell.swift
//  UniGrade
//
//  Created by Tom Woodley on 01/07/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class AssessmentsCell: UITableViewCell {
    @IBOutlet weak var thisView: OverviewView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(assesment: Assessment) {
        thisView.updateViews(overview: assesment)
    }

}
