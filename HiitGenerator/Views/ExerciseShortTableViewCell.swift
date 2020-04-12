//
//  ExerciseShortTableViewCell.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/11/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import UIKit

class ExerciseTableViewCell : UITableViewCell {
    var cellContent: UIView {
        get {
            return UIView()
        }
        set { }
    }
    var exerciseTitle: UILabel {
        get {
            return UILabel()
        }
        set { }
    }
}

class ExerciseShortTableViewCell: ExerciseTableViewCell {
    
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

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var cellTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundedView.roundCorners(radius: 27.0)
        self.roundedView.setBorder(width: 2.0, color: UIColor.blue)
    }
    
    func animateExpand() {
        self.heightConstraint.constant = 180
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
