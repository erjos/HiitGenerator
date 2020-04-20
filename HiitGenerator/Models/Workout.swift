//
//  Workout.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/19/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import Foundation

enum CircuitType: Int {
    case small = 3
    case medium = 5
    case large = 8
}

/// Set this delegate to receive callbacks for workout state change and workout timer updates
typealias WorkoutDelegate = ActiveWorkoutDelegate & WorkoutTimerDelegate

/// An active workout object that has been created and started by the user
class ActiveWorkout {
    
    var exercises: [Exercise]
    var workoutState : WorkoutState = .unstarted
    private var timer = WorkoutTimer()
    private (set) var isPaused = false
    
    weak var workoutDelegate: WorkoutDelegate?
    
    init(_ exercises: [Exercise], _ delegate: WorkoutDelegate) {
        self.exercises = exercises
        self.workoutDelegate = delegate
        self.timer.delegate = delegate
    }
    
    func startWorkout() {
        self.workoutState = .active
        self.timer.runTimer(startTime: 0)
        self.workoutDelegate?.didStartWorkout(self)
    }
    
    func resumeWorkout() {
        self.isPaused = false
        self.timer.resumeTimer()
        self.workoutDelegate?.didResumeWorkout(self)
    }
    
    func pauseWorkout() {
        self.timer.pauseTimer()
        self.isPaused = true
        self.workoutDelegate?.didPauseWorkout(self)
    }
}

protocol ActiveWorkoutDelegate: class {
    
    func didPauseWorkout(_ workout: ActiveWorkout)
    func didResumeWorkout(_ workout: ActiveWorkout)
    func didStartWorkout(_ workout: ActiveWorkout)
    func didComplete(_ exercise: Exercise, workout: ActiveWorkout)
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

//TODO: consider if we want a stopped?
enum WorkoutState {
    case unstarted
    case active
    case exerciseBreak
    case circuitBreak
    case finished
}
