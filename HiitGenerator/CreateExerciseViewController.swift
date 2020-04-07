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
    
    lazy var completion : CompletionOptional = { [unowned self] error_optional in
        guard let error = error_optional else { return }
        let alertViewController = UIAlertController(title: "Something went wrong.", message: error.localizedDescription, preferredStyle: .alert)
        let dismissUIAlertAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertViewController.addAction(dismissUIAlertAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressSave(_ sender: Any) {
        
        guard let name = self.nameField.text,
            !name.isEmpty else { return }
        
        guard let description = self.descriptionTextView.text,
            !description.isEmpty else { return }
        
        // Only require the first instruction, the second and third are optional
        guard let stepOne = self.instructionsOne.text,
            !stepOne.isEmpty else { return }
        
        var instructions = [stepOne]
        
        if let stepTwo = self.instructionsTwo.text,
            !stepTwo.isEmpty {
            instructions.append(stepTwo)
        }
        
        if let stepThree = self.instructionsThree.text,
            !stepThree.isEmpty {
            instructions.append(stepThree)
        }
        
        let types = self.getTypes()
        guard let difficulty_string = self.difficultyField.text else { return }
        let difficulty = self.getDifficulty(difficultyString: difficulty_string)
        let exercise = Exercise(name: name, description: description, instructions: instructions, workoutTypes: types, difficulty: difficulty)
        
        WorkoutDataModels.writeExerciseToFirestore(exercise: exercise, completion: self.completion)
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
}
