//
//  ExerciseExpandedTableViewCell.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/12/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import UIKit

class ExerciseExpandedTableViewCell: ExerciseTableViewCell {
    
    override var cellContent: UIView {
        get {
            return self.roundedView
        }
        set {
            self.roundedView = newValue
        }
    }
    
    override var exerciseTitle: UILabel {
        get {
            return self.cellTitle
        }
        set{
            self.cellTitle = newValue
        }
    }

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var roundedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundedView.roundCorners(radius: 27.0)
        self.roundedView.setBorder(width: 2.0, color: UIColor.blue)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
