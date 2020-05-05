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
//TODO: consider a dark mode
//TODO: shuffle animation when generating the workout

class GetWorkoutsViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var workoutsTable: UITableView!
    
    var activeWorkout: ActiveWorkout?
    
    /// Set reference of all the exercises we have
    private var exerciseSet = Set<Exercise>()
    
    private var dataSource: [Exercise] = [] {
        didSet{
            self.workoutsTable.reloadData()
        }
    }
    
    let EXPANDED_CELL_HEIGHT: CGFloat = 332
    let COLLAPSED_CELL_HEIGHT: CGFloat = 80

    //TODO: this presents problems if the indexPath changes - any change to the table should only be able to be done when this is set to nil
    /// This variable is used to keep a reference to which cell is currently expanded. No more than one cell may be expanded at any time, if this variable is nil then all cells are collapsed.
    private var expandedCell: IndexPath? {
        didSet {
            self.workoutsTable.beginUpdates()
            self.workoutsTable.endUpdates()
            
            //TODO: not sure if this does anything right now :/
            self.workoutsTable.layoutSubviews()
        }
    }
    
    @IBAction func didPressPlay(_ sender: Any) {
        guard let currentWorkout = self.activeWorkout else { return }
        currentWorkout.handlePlayPause()
        
        self.topView.stopBlink()
    }
    
    @IBAction func didPressGetExercises(_ sender: Any) {
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
            
            //Create and set active workout
            self.activeWorkout = ActiveWorkout(workout, self)
        }
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.workoutsTable.delegate = self
        self.workoutsTable.dataSource = self
        self.workoutsTable.register(UINib.init(nibName: "ExerciseExpandableTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "exercise_expandable_cell")
        self.workoutsTable.separatorStyle = .none
        self.topView.roundCorners(radius: 25.0, corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        self.topView.blink(duration: 0.75, delay: 0.0, color: UIColor.systemBlue, alpha: 0.0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "view_workout" {
            guard let vc = segue.destination as? ShowWorkoutViewController,
                let indexPath = sender as? IndexPath else { return }
            vc.exercise = self.dataSource[indexPath.row]
        }
    }
}

extension GetWorkoutsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = ExerciseExpandableTableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "exercise_expandable_cell") as! ExerciseExpandableTableViewCell
        let exercise = self.dataSource[indexPath.row]
        cell.configure(for: exercise)
        cell.selectionStyle = .none
        return cell
    }
}

extension GetWorkoutsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == self.expandedCell {
            return self.EXPANDED_CELL_HEIGHT
        }
        return self.COLLAPSED_CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // TODO: Consider prevent this if the workout is in flux
        self.expandedCell = indexPath
    }
}

extension GetWorkoutsViewController: ActiveWorkoutDelegate {
    
    func didBeginExercise(_ workout: ActiveWorkout, exerciseIndex: Int) {
        //It could be better to pass this data along all the way through... I dont like the disconnect here
        let indexPath = IndexPath(row: exerciseIndex, section: 0)
        self.expandedCell = indexPath
        self.playButton.setImage(#imageLiteral(resourceName: "pause_button_fill"), for: .normal)
    }
    
    func didPauseWorkout(_ workout: ActiveWorkout) {
        self.playButton.setImage(#imageLiteral(resourceName: "play_button_fill"), for: .normal)
    }
    
    func didResumeWorkout(_ workout: ActiveWorkout) {
        self.playButton.setImage(#imageLiteral(resourceName: "pause_button_fill"), for: .normal)
    }
    
    func didCompleteExercise(_ workout: ActiveWorkout) {
        // TODO: put the screen in break state
    }
    
    func didCompleteCircuit(_ circuit: Int, workout: ActiveWorkout) {
        
    }
    
    func didCompleteWorkout(_ workout: ActiveWorkout) {
        
    }
}

extension GetWorkoutsViewController: WorkoutTimerDelegate {
    
    func didUpdateTimer(seconds: Double) {
        let timerText = String.getTimeString(time: seconds)
        self.timerLabel.text = timerText
    }
    
    func didFinishTimer() {
        guard let currentWorkout = self.activeWorkout else { return }
        
        switch currentWorkout.workoutState {
        case .active :
             currentWorkout.finishSet()
        case .setBreak :
            currentWorkout.beginSet()
        case .circuitBreak:
            currentWorkout.beginSet()
        case .finished:
            //TODO: --> This may never happen because we call completed delegate function from the finishSet function
            print("workout finished")
        case .unstarted:
            // this should also never happen.
            print("That was weird")
        }
    }
}
