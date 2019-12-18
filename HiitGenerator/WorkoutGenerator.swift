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
    //default to all - allow user to switch these add/remove - say something like "we'll try to reduce"
    var targetAreas : [TargetArea] = [.Abs,.Arms,.Back,.Biceps,.Cardio,.Chest,.Core,.Glutes,.Hamstring,.Legs,.Obliques,.Quads,.Shoulders,.Triceps]
    
    //for the generator maybe we wont account for a flexible target area, but then offer the customization feature to those who need to fine tune their workouts due to injury or fatigue
    func generateWorkout(_ targetAreas: [TargetArea], _ workoutLength: WOLength, _ components: WOComponents) {
        //we need at least one core focus
        //one all body
        //one arms
        //one legs
        
        //start with an inclusive list of target areas a user desires
        //create a getRandomWorkoutFunction that pulls one random workout according to the target areas passed in
        //once we have one workout, we check off the areas that we have covered in the workout
        //we use this to eliminate similar workouts from our pool as we generate the next one
        //once we eliminate all or cannot get another workout with what we have, we reset the constraints
        //could customize the workouts a bit by allowing us to pass in higher frequency of certain areas
        //
        
        //tricky part will be pulling in random assortment of all the different types of workouts - plus we dont really have ones defined as each - we could create a hidden field on each which is like category (1-3) and make sure we have 1 of each category in the workouts...
    }
    //init()
    
    //probably dont need this right away but would be nice later on
    //have the ability to customize this later on - add remove workouts that the user doesnt want or like
}
