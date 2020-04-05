//
//  CreateExerciseViewController.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/4/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import UIKit

class CreateExerciseViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var InstructionsOne: UITextField!
    @IBOutlet weak var InstructionsTwo: UITextField!
    @IBOutlet weak var InstructionsThree: UITextField!
    @IBOutlet weak var cardioSwitch: UISwitch!
    @IBOutlet weak var armsSwitch: UISwitch!
    @IBOutlet weak var legsSwitch: UISwitch!
    @IBOutlet weak var coreSwitch: UISwitch!
    @IBOutlet weak var difficultyField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressSave(_ sender: Any) {
        //Validate all the fields and save the new workout
    }
    
    @IBAction func didPressBack(_ sender: Any) {
        self.dismiss(animated: true) {
            //completion
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
