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
// experiment with drop shadows for top view and cards
// The next workout should expand during the break so you can prep for what you need to do next
// There should be a 5 second countdown before the workout starts where the screen flashes or something.
// What about a restart method?
// You should be able to expand and collapse other cells during breaks, as long as the workout is not active... But if you pause you should also be able to expand
// We should scroll to the focused cell

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
    
    //TODO: consider removing this
    func startWorkout() {
        self.beginSet()
    }
    
    func beginSet() {
        self.workoutState = .active
        self.timer.runTimer(startTime: self.setTime, countMode: .down)
        self.workoutDelegate?.didBeginExercise(self, exerciseIndex: self.currentExerciseIndex)
    }
    
    func finishSet() {
        
        // Increment the exercise index
        self.currentExerciseIndex += 1
        
        // Check if our circuit is over
        guard self.currentExerciseIndex != self.exercises.count else {
            
            // Increment the circuit count
            self.completedCircuitCount += 1
            
            // Check if the workout is over
            guard self.completedCircuitCount != self.circuitType.rawValue else {
                self.handleWorkoutCompleted()
                return
            }
            
            self.handleCircuitCompleted()
            return
        }
        
        self.handleSetCompleted()
    }
    
    /// Called by the action on the view controller to
    func handlePlayPause(){
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
    
    private func handleSetCompleted() {
        self.workoutDelegate?.didCompleteExercise(self)
        self.workoutState = .setBreak
        self.timer.runTimer(startTime: self.setBreakTime, countMode: .down)
    }
    
    private func handleCircuitCompleted() {
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
    //TODO: pass info for cell to expand in did complete so we can expand before the next one starts
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
