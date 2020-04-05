//
//  CreateExerciseViewController.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/4/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//
import UIKit
import Foundation

class CreateExerciseViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var instructionsOne: UITextField!
    @IBOutlet weak var instructionsTwo: UITextField!
    @IBOutlet weak var instructionsThree: UITextField!
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
        
        guard let name = self.nameField.text else { return}
        guard let description = self.descriptionTextView.text else { return }
        
        // Only require the first instruction, the second and third are optional
        guard let stepOne = self.instructionsOne.text else { return }
        var instructions = [stepOne]
        
        if let stepTwo = self.instructionsTwo.text {
            instructions.append(stepTwo)
        }
        if let stepThree = self.instructionsThree.text {
            instructions.append(stepThree)
        }
        
        let types = self.getTypes()
        
        guard let difficulty_string = self.difficultyField.text else { return }
        
        let difficulty = self.getDifficulty(difficultyString: difficulty_string)
        
        let exercise = Exercise(name: name, description: description, instructions: instructions, workoutTypes: types, difficulty: difficulty)
        
        WorkoutDataModels.writeExerciseToFirestore(exercise: exercise)
    }
    
    func getTypes() -> [WorkoutType] {
        
        // The array should be constructed according to the order returned by allCases
        let switchArray = [self.armsSwitch, self.legsSwitch, self.cardioSwitch, self.coreSwitch]
        let array = WorkoutType.allCases
        
        var types = [WorkoutType]()
        for (toggle, type) in zip(switchArray, array) {
            if toggle!.isOn {
                types.append(type)
            }
        }
        return types
    }
    
    func getDifficulty (difficultyString: String) -> Difficulty {
        
        switch difficultyString {
        case "1" :
            return .One
        case "2" :
            return .Two
        case "3" :
            return .Three
        default :
            return .Two
        }
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
