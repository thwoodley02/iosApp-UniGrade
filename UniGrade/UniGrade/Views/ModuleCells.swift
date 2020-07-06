//
//  TargetTitleCell.swift
//  UniGrade
//
//  Created by Tom Woodley on 29/06/2020.
//  Copyright © 2020 Tom Woodley. All rights reserved.
//

import UIKit





class ModuleTitleCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}

class ModuleContentCell: UICollectionViewCell {
    
    
    @IBOutlet weak var overview: OverviewView!
    
    public func updateViews(module: Module) {
        overview.updateViews(overview: module)
        //overview.bounds.size.width = bounds.size.width
    }

}


