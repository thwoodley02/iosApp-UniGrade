//
//  AssessmentsCell.swift
//  UniGrade
//
//  Created by Tom Woodley on 01/07/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class AssessmentsCell: UICollectionViewCell {
    @IBOutlet weak var thisView: OverviewView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func updateViews(assesment: Assessment) {
        thisView.updateViews(overview: assesment)
    }

}
