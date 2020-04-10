//
//  CreateExerciseViewController.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/4/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//
import UIKit
import Foundation

//TODO: would be good to not have to refresh the data - need a way to get the most updated stuff everywhere
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
    
    private var typeSwitches : [UISwitch] {
        return [self.cardioSwitch, self.armsSwitch, self.legsSwitch, self.coreSwitch]
    }
    
    private var instructionFields : [UITextField] {
        return [self.instructionsOne, self.instructionsTwo, self.instructionsThree]
    }
    
    // Only exists when editing an existing exercise
    var exercise: Exercise?
    
    lazy var completion : CompletionOptional = { [unowned self] error_optional in
        guard let error = error_optional else { return }
        let alertViewController = UIAlertController(title: "Something went wrong.", message: error.localizedDescription, preferredStyle: .alert)
        let dismissUIAlertAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertViewController.addAction(dismissUIAlertAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let exercise = self.exercise {
            self.setupPageFor(exercise: exercise)
        }
    }
    
    func setupPageFor(exercise: Exercise) {
        self.nameField.text = exercise.name
        self.descriptionTextView.text = exercise.description
        
        // Setup instructions
        let fieldsArray = [instructionsOne,instructionsTwo,instructionsThree]
        for (step, field) in zip(exercise.instructions, fieldsArray) {
            field?.text = step
        }
        
        // Setup the switches
        for type in exercise.workoutTypes {
            switch type {
            case .Cardio:
                self.cardioSwitch.isOn = true
            case .Arms:
                self.armsSwitch.isOn = true
            case .Legs:
                self.legsSwitch.isOn = true
            case .Core:
                self.coreSwitch.isOn = true
            }
        }
        
        self.difficultyField.text = exercise.difficulty.rawValue.description
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
        
        var new_exercise = Exercise(name: name, description: description, instructions: instructions, workoutTypes: types, difficulty: difficulty)
        
        guard let existing_exercise = self.exercise else {
            WorkoutDataModels.writeExerciseToFirestore(exercise: new_exercise, completion: self.completion)
            return
        }
        
        // save to existing exercise path
        //TODO: find a better way to do this
        new_exercise.uuid = existing_exercise.uuid
        
        let alert = UIAlertController(title: "Are you sure you want to overwrite?", message: "You are about to overwrite this data. Are you sure you want to save?", preferredStyle: .alert)
            
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let save = UIAlertAction(title: "Save", style: .default) { [unowned self] (action) in
            self.dismiss(animated: true) {
                WorkoutDataModels.updateExercise(exercise: new_exercise) { (error_optional) in
                    //TODO: handle the error
                }
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(save)
            
        self.present(alert, animated: true, completion: nil)
    }
    
    func getTypes() -> [WorkoutType] {
        
        // The array should be constructed according to the order returned by allCases
        let switchArray = [self.armsSwitch, self.legsSwitch, self.cardioSwitch, self.coreSwitch]
        let array = WorkoutType.allCases
        
        var types = [WorkoutType]()
        for (toggle, type) in zip(self.typeSwitches, array) {
            if toggle.isOn {
                types.append(type)
            }
        }
        return types
    }
    
    func getDifficulty(difficultyString: String) -> Difficulty {
        
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
