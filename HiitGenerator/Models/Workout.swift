//
//  Workout.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/19/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import Foundation

/// Circuit type for the workout represents how many circuits the workout will include. Small, medium and large correspond to 3, 5 and 8 respectively
enum CircuitType: Int {
    case small = 3
    case medium = 5
    case large = 8
}

/// Set this delegate to receive callbacks for workout state change and workout timer updates
typealias WorkoutDelegate = ActiveWorkoutDelegate & WorkoutTimerDelegate

/// An active workout object that has been created and started by the user
class ActiveWorkout {
    
    // MARK - STATE VARIABLES
    
    private var exercises: [Exercise]
    var workoutState : WorkoutState = .unstarted
    private var setTime: Double = 45 // TODO: make this dynamic based on difficulty or customizable
    var circuitType: CircuitType = .medium
    
    private var currentExerciseIndex = 0
    
    private var completedCircuitCount = 0
    private var setBreakTime: Double = 30 // TODO: make dynamic
    private var circuitBreakTime: Double = 60 // TODO: make dynamic
    
    private var timer = WorkoutTimer()
    
    private (set) var isPaused = false //TODO: consider moving this to the timer if we do not need to access it
    
    weak var workoutDelegate: WorkoutDelegate?
    
    init(_ exercises: [Exercise], _ delegate: WorkoutDelegate) {
        self.exercises = exercises
        self.workoutDelegate = delegate
        self.timer.delegate = delegate
    }
    
    func startWorkout() {
        self.beginSet()
    }
    
    func beginSet() {
        self.workoutState = .active
        self.timer.runTimer(startTime: self.setTime, countMode: .down)
        self.workoutDelegate?.didStartWorkout(self)
    }
    
    //TODO: break this down into small methods
    
    func finishSet() {
        
        // Increment the exercise index
        self.currentExerciseIndex += 1
        
        // Check if our circuit is over
        if self.currentExerciseIndex == self.exercises.count {
        
            // Increment the circuit count
            self.completedCircuitCount += 1
            
            // Check if the workout is over
            if self.completedCircuitCount == self.circuitType.rawValue {
                
                // Handle workout completed
                self.workoutDelegate?.didCompleteWorkout(self)
            }
            
            // Handle circuit completed
            self.workoutDelegate?.didCompleteCircuit(self.completedCircuitCount, workout: self)
        }
        
        // Handle set completed
        self.workoutDelegate?.didCompleteExercise(self)
        self.workoutState = .setBreak
        self.timer.runTimer(startTime: self.setBreakTime)
    }
    
    func resumeWorkout() {
        self.isPaused = false
        self.timer.resumeTimer()
        self.workoutDelegate?.didResumeWorkout(self)
    }
    
    func pauseWorkout() {
        self.isPaused = true
        self.timer.pauseTimer()
        self.workoutDelegate?.didPauseWorkout(self)
    }
}

protocol ActiveWorkoutDelegate: class {
    
    func didPauseWorkout(_ workout: ActiveWorkout)
    func didResumeWorkout(_ workout: ActiveWorkout)
    func didStartWorkout(_ workout: ActiveWorkout)
    func didCompleteExercise(_ workout: ActiveWorkout)
    func didCompleteCircuit(_ circuit: Int, workout: ActiveWorkout)
    func didCompleteWorkout( _ workout: ActiveWorkout)
}

// Model for basic workout that might be stored in the database
struct Workout {
    // list of exercises to be performed in each circuit
    var exercises : [Exercise]
    // the number of circuits to be completed in the workout
    var circuits: Int
}

enum WorkoutState {
    case unstarted
    case active
    case setBreak
    case circuitBreak
    case finished
}
