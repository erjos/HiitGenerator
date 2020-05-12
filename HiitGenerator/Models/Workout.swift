//
//  Workout.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/19/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import Foundation

//SOME NOTES:

// Highlight the active workout with an outline or something to make it pop

// experiment with drop shadows for top view and cells

// There should be a 5 second countdown before the workout starts where the screen flashes or something.

// What about a restart/reset method?

// The app should scroll to the focused cell

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
    
    private (set) var currentExerciseIndex = 0
    
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
    
    //TODO: consider removing this
    func startWorkout() {
        self.beginSet()
    }
    
    func beginSet() {
        self.workoutState = .active
        self.timer.runTimer(startTime: self.setTime, countMode: .down)
        self.workoutDelegate?.didBeginExercise(self, exerciseIndex: self.currentExerciseIndex)
    }
    
    /// Prepares the workout to begin the next step, notifies the delegate of the current workout state via handleSetCompleted, handleCircuitCompleted or handleWorkoutCompleted
    func finishSet() {
        
        // Get next exercise index - Increment the exercise index
        let nextExerciseIndex = self.currentExerciseIndex + 1
        
        //self.currentExerciseIndex += 1
        
        // Check if circuit is over
        guard nextExerciseIndex != self.exercises.count else {
            
            
            
            // Check if workout is over
            guard self.completedCircuitCount != self.circuitType.rawValue else {
                self.handleWorkoutCompleted()
                return
            }
            
            self.handleCircuitCompleted()
            return
        }
        
        self.handleSetCompleted(setIndex: self.currentExerciseIndex)
        self.currentExerciseIndex = nextExerciseIndex
    }
    
    /// Called by the action on the view controller
    func handleNext() {
        //This tells the timer delegate that the current time period has completed and initiates the beginning of the next one in the sequence
        self.timer.delegate?.didFinishTimer()
    }
    
    /// Called by the action on the view controller to pause or resume the workout
    func handlePlayPause() {
        if self.isPaused {
            self.resumeWorkout()
        } else {
            switch self.workoutState {
            case .unstarted, .finished:
                
                //TODO: may not need start workout anymore
                self.startWorkout()
            case .active, .setBreak, .circuitBreak:
                self.pauseWorkout()
            }
        }
    }
    
    private func resumeWorkout() {
        self.isPaused = false
        self.timer.resumeTimer()
        self.workoutDelegate?.didResumeWorkout(self)
    }
    
    private func pauseWorkout() {
        self.isPaused = true
        self.timer.pauseTimer()
        self.workoutDelegate?.didPauseWorkout(self)
    }
    
    //TODO: this naming is confusing, either refer to the item as exercise or set, but not both
    private func handleSetCompleted(setIndex: Int) {
        self.workoutDelegate?.didCompleteExercise(self, exerciseIndex: setIndex)
        self.workoutState = .setBreak
        self.timer.runTimer(startTime: self.setBreakTime, countMode: .down)
    }
    
    //TODO: make these methods more consistent in naming - do they handle or do they just take the action
    private func handleCircuitCompleted() {
        // Increment circuit count
        self.completedCircuitCount += 1
        // Reset exercise index to prep for next circuit
        self.currentExerciseIndex = 0
        self.workoutDelegate?.didCompleteCircuit(self.completedCircuitCount, workout: self)
        self.workoutState = .circuitBreak
        self.timer.runTimer(startTime: self.circuitBreakTime, countMode: .down)
    }
    
    private func handleWorkoutCompleted() {
        self.workoutDelegate?.didCompleteWorkout(self)
        self.workoutState = .finished
    }
}

protocol ActiveWorkoutDelegate: class {
    
    func didPauseWorkout(_ workout: ActiveWorkout)
    func didResumeWorkout(_ workout: ActiveWorkout)
    func didBeginExercise(_ workout: ActiveWorkout, exerciseIndex: Int)
    func didCompleteExercise(_ workout: ActiveWorkout, exerciseIndex: Int)
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
