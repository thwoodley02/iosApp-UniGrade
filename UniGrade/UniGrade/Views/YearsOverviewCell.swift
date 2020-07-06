//
//  YearsOverviewCell.swift
//  UniGrade
//
//  Created by Tom Woodley on 26/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit

class YearsOverviewCell: UICollectionViewCell {
    
    @IBOutlet weak var overview: OverviewView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func updateViews(year: Year, cellWidth: CGFloat) {
        overview.cellWidth = cellWidth
        overview.updateViews(overview: year)
    }
    
}
