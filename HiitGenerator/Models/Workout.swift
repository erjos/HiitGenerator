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

class CurrentWorkout {
    
    var workoutState : WorkoutState?
    
    weak var workoutDelegate: ActiveWorkoutDelegate?
    
    var workout: Workout?
    
    func startWorkout() {
        //tell the delegate that we started the workout
        self.workoutDelegate?.didStartWorkout(self)
    }
    
    // TIMER LOGIC
    var seconds: Double = 0
    var timerDevice = Timer()
    
    func runTimer() {
        timerDevice.invalidate()
        seconds = 0
        timerDevice = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds += 1
        
        //Move this back to the view Controller
        //timerLabel.text = "\(timeString(time: seconds))"
    }
}

protocol ActiveWorkoutDelegate: class {
    
    func didPauseWorkout(_ workout: CurrentWorkout)
    func didStartWorkout(_ workout: CurrentWorkout)
    func didComplete(_ exercise: Exercise, workout: CurrentWorkout)
    func didCompleteCircuit(_ circuit: Int, workout: CurrentWorkout)
    func didCompleteWorkout( _ workout: CurrentWorkout)

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
    case Unstarted
    case Active
    case ExerciseBreak
    case CircuitBreak
    case Paused
    case Finished
}

//TODO: consider if we want to keep track of the active workout
struct ActiveWorkout {
    
}

//TODO: consider removing this until we actually decide to implement it or not
protocol Observable {
    associatedtype T
    
    var value: T { get set }
    
    var observers: [AnyObject] { get set }
    
    func subscribe(observer: AnyObject, block: (_ newValue: T, _ oldValue: T) -> ())
    
    func unsubscribe(observer: AnyObject)
}
