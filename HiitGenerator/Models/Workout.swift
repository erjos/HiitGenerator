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
    weak var updateDelegate: Updatable?
    
    
    func pauseWorkout() {
        
    }
    
    func startWorkout() {
        
    }
    
    func finishedCircuit() {
        
    }
    
    func finishedExercise() {
        
    }
}


protocol Updatable: class {
    func  updatedWorkout(_ workout: CurrentWorkout)
}

//
protocol Observable {
    associatedtype T
    
    var value: T { get set }
    
    var observers: [AnyObject] { get set }
    
    func subscribe(observer: AnyObject, block: (_ newValue: T, _ oldValue: T) -> ())
    
    func unsubscribe(observer: AnyObject)
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

struct ActiveWorkout {
    
}
