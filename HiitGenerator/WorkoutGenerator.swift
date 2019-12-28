//
//  WorkoutGenerator.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 12/18/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import Foundation

//these enums help define workout preferences
enum WOLength : Int {
    case short = 20
    case medium = 40
    case long = 60
}

enum WOComponents {
    case bodyWeight
    case dumbells
    //case medicineBall
    //case kettleBell
}

class WOGenerator {
    //workout preferences
    var length : WOLength!
    var components : WOComponents!
    var targetAreas : [TargetArea] = [.Abs,.Arms,.Back,.Biceps,.Cardio,.Chest,.Core,.Glutes,.Hamstring,.Legs,.Obliques,.Quads,.Shoulders,.Triceps]
    
    lazy var workoutGetter : WorkoutStorageProtocol = WorkoutDataModels()
    
    func generateWorkout(_ exclude: [TargetArea], _ workoutLength: WOLength, _ components: WOComponents) {

        let validWorkouts = workoutGetter.getWorkouts()
            .filter { $0.targetAreas
                .first { exclude
                    .contains($0)
                } == nil
        }
        
        // randomly pick one from the list
        let firstWorkout = validWorkouts.randomElement()
        
        //update workout pool and pull another one
    }
    
    //If we know the types of  workouts we want to incorporate we can have partitioned lists ahead of time so that we dont need to resort or whatever...
    
    //init()
    
    //probably dont need this right away but would be nice later on
    //have the ability to customize this later on - add remove workouts that the user doesnt want or like
}
