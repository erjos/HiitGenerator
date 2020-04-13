//
//  GetWorkoutsViewController.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/6/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import UIKit

//TODO: need a solution to help prevent adding workouts that are too similar ie. inchworm / inchworm + pushup

//TODO: a button to just randomly replace a single workout if you dont like it - like a request new function...
//Do we want to give the app a dark mode and a light mode

class GetWorkoutsViewController: UIViewController {

    @IBOutlet weak var workoutsTable: UITableView!
    
    /// This variable is used to keep a reference to which cell is currently expanded. No more than one cell may be expanded at any time, if this variable is nil then all cells are collapsed.
    
    //TODO: this presents problems if the indexPath changes - any change to the table should only be able to be done when this is set to nil
    private var expandedCell: IndexPath? {
        didSet {
            self.workoutsTable.beginUpdates()
            self.workoutsTable.endUpdates()
            
            //TODO: not sure if this does anything right now :/
            self.workoutsTable.layoutSubviews()
        }
    }
    
    @IBAction func didPressGetWorkouts(_ sender: Any) {
        WorkoutDataModels.getAllExercises { (snapshot_opt, error_opt) in
            if let _ = error_opt {
                // TODO: Handle Error
            } else {
                
                var exercise_set = Set<Exercise>()
                
                snapshot_opt!.documents.forEach { (document_snapshot) in
                    guard let exercise = Exercise(fromData: document_snapshot.data(), id: document_snapshot.documentID) else {
                        fatalError("Struct init returned nil. Check incoming data")
                    }
                    
                    exercise_set.insert(exercise)
                }
                
                // Store the set and the array
                self.exerciseSet = exercise_set
                self.dataSource = Array(exercise_set)
            }
        }
    }
    
    @IBAction func didPressGenerateWorkout(_ sender: Any) {
        if let workout = self.generateWorkout(circuitType: .large) {
            self.dataSource = workout
        }
    }
    
    enum CircuitType: Int {
        case small = 3
        case medium = 5
        case large = 8
    }
    
    // Uses a set so we can quickly tell whether we already have a workout
    private func generateWorkout(circuitType: CircuitType) -> [Exercise]? {
        var workout = [Exercise]()
        var set_snapshot = self.exerciseSet
        
        for _ in 0..<circuitType.rawValue {
            guard let random_exercise = set_snapshot.randomElement() else { return nil }
            // Remove that element from the set so we do not pull it again
            set_snapshot.remove(random_exercise)
            workout.append(random_exercise)
        }
        return workout
    }
    
    private var exerciseSet = Set<Exercise>()
    
    private var dataSource: [Exercise] = [] {
        didSet{
            self.workoutsTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.workoutsTable.delegate = self
        self.workoutsTable.dataSource = self
        self.workoutsTable.register(UINib.init(nibName: "ExerciseExpandableTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "exercise_expandable_cell")
        self.workoutsTable.separatorStyle = .none
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "view_workout" {
            guard let vc = segue.destination as? ShowWorkoutViewController,
                let indexPath = sender as? IndexPath else { return }
            vc.exercise = self.dataSource[indexPath.row]
        }
    }
}

extension GetWorkoutsViewController: UIScrollViewDelegate {
    
}

extension GetWorkoutsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = ExerciseTableViewCell()
        
        cell = tableView.dequeueReusableCell(withIdentifier: "exercise_expandable_cell") as! ExerciseExpandableTableViewCell

        cell.exerciseTitle.text = self.dataSource[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
}

extension GetWorkoutsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == self.expandedCell {
            return 332
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.expandedCell = indexPath
        //self.performSegue(withIdentifier: "view_workout", sender: indexPath)
    }
}
