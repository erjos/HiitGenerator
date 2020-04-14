//
//  ExerciseShortTableViewCell.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/11/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import UIKit

class ExerciseExpandableTableViewCell: UITableViewCell {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var instructionsOneLabel: UILabel!
    @IBOutlet weak var instructionsTwoLabel: UILabel!
    @IBOutlet weak var instructionsThreeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundedView.roundCorners(radius: 27.0)
        self.roundedView.setBorder(width: 2.0, color: UIColor.blue)
        
        self.instructionsTwoLabel.text = ""
        self.instructionsThreeLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //TODO: determine if we need to use this
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(for exercise: Exercise){
        self.cellTitle.text = exercise.name
        self.descriptionLabel.text = exercise.description
        self.typesLabel.text = exercise.workoutTypes.map{$0.rawValue}.joined(separator: " - ")
        
        // Setup instructions
        let labelArray = [instructionsOneLabel, instructionsTwoLabel, instructionsThreeLabel]
        for (step, label) in zip(exercise.instructions, labelArray) {
            label?.text = "• \(step)"
        }
    }
}
