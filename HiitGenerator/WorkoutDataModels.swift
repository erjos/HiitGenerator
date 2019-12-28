//
//  WorkoutDataModels.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 11/30/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import Foundation
//An idea would be to create a crowd-source component - let users add workouts of their own
//Save workouts that individuals create and we can send them out to others...

//offer a disclaimer before allowing users to interact with the app...

//Quick Description of workout structures
//Workouts are made up of Rounds - (1-3 depending on length)
//Each round represents 3 cycles through sets of 3 different workouts (so you complete each workout 9 times in a round)
//One cycle consists of 3 workouts with 30 seconds of rest in between each workout and 45 seconds of work for each excercise
//in between cycles you rest for 1 minute
//then repeat

//in between rounds you rest for 2-3 minutes before starting a new round with new excercises

//to start we'll just make it a standard work/rest time...
//things to customize - shorter/longer rest times in between excercises, sets and cycles... longer work periods?

//Complete workout avtivity
struct Routine {
    var cycles: [Cycle]!
    var activeTime: Int!
    var restTime: Int!
    var difficulty: Difficulty!
    var routineDuration: Int!
}

//need to keep track of where we are
//cycle 1 - excercise 1... how do we keep track of progess?

//3 make up a routine - need different times in between excercises and in between cycles
struct Cycle {
    var workouts: [Exercise]!
    var activeTime: Int!
    //rest time in between excercises
    var restTime: Int!
    //break in between sets
    var setBreak: Int!
    var cycleDuration: Int!
    var difficulty: Difficulty!
    var summary: String!
}

protocol WorkoutStorageProtocol {
    func getWorkouts() -> [Exercise]
}

class WorkoutDataModels : WorkoutStorageProtocol {
    
    //legs focus
    func getTypeOne() -> [Exercise] {
        return [jumpSquats, splitLunges, runUps]
    }
    
    //arms/upper body focus
    func getTypeTwo() -> [Exercise] {
        return [shoulderPress, pushups, bicepCurl]
    }
    
    //core, whole body, etc.
    func getTypeThree() -> [Exercise] {
        return []
    }
    
    func getWorkouts() -> [Exercise] {
        return [shoulderPress, pushups, jumpSquats, shoulderTaps, splitLunges, bicepCurl, burpee, downUps, runUps]
    }
    
    //Warm Up
    //jumping jacks, squats, scoops, lunges, inchworms, leg raises
    //short run?
    
    //Workout 1 : Arms, Chest, Core, Legs
    let shoulderPress = Exercise(name: "Shoulder Press", description: "Raise two dumbells (one in each hand) above your head repeatedly. Start with your arms bent at chest level and lift the dumbells up as you straighten your arms. Be sure to keep your core tight while performing this excercise.", targetAreas: [.Shoulders, .Arms], difficulty: .Medium)
    
    let pushups = Exercise(name: "Pushups", description: "Start on the ground in plank position. Bend your arms to lower your chest to the ground. Straighten your arms and return to plank position. Repeat. To make this excercise easier, place your knees on the ground.", targetAreas: [.Chest, .Core, .Arms], difficulty: .Easy)
    
    let jumpSquats = Exercise(name: "Jump-squat", description: "Stand square with feet shoulder width apart. Lower your waist back as if you were sitting in a chair and come to a complete squat position. Be sure to keep your weight back and on your heels and make sure your knees don't cross the plane of your toes. Explode upwards as you straighten your legs and jump into the air.", targetAreas: [.Legs], difficulty: .Easy)
    
    //Workout 2 : Abs, Legs, Biceps
    let shoulderTaps = Exercise(name: "Should taps", description: "Start in plank position. One at a time tap your shoulders with the opposite arm. Keep your core tight and try not to rotate your body when you go to one arm.", targetAreas: [.Core, .Abs, .Arms], difficulty: .Medium)
    
    let splitLunges = Exercise(name: "Split Lunges", description: "Drop one leg back into a deep lunge position. Return to neutral and repeat with opposite leg.", targetAreas: [.Legs], difficulty: .Medium)
    
    let bicepCurl = Exercise(name: "Bicep Curl", description: "Using dumbell, barbell or tension cords complete bicep curls simultaneously in right and left arms with a light weight. Focus on form and isolating your bicep", targetAreas: [.Arms, .Biceps], difficulty: .Easy)
    
    //Workout 3 : Chest, Legs, Abs, Cardio
    let burpee = Exercise(name: "Burpee", description: "Start standing. Drop down into plank position. Do a pushup. Return to start and jump in the air. Focus on swift transitions between the postions. You should be moving fluidly between the positions. To make this excercise easier, don't do a jump at the end, just return to your starting position.", targetAreas: [.Chest, .Core, .Legs], difficulty: .Medium)
    //Not sure if that's the correct name for this
    let downUps = Exercise(name: "Down/Ups", description: "Start in plank position. One arm at a time move from your hand to your elbow plank position. Then move back to your hand position in the reverse order.", targetAreas: [.Core, .Abs], difficulty: .Easy)
    let runUps = Exercise(name: "Run ups", description: "Using a platform, place one foot on the platform and rapidly remove it, replacing it with the opposite foot. This should create a running motion as you switch which foot is on the platform.", targetAreas: [.Legs, .Cardio], difficulty: .Easy)
    
    // Generate will randomly pull in workouts and wont repeat...
    
    // Build / Customize would allow you to search the workout database and add to your workout orrrr create your own
    // Users can add workouts to the database whenever they want and immediately use them in their own workouts... we just need to moderate if what gets added to the main workout bank.
    
    
    //This workout the first three are legs...
    
    // squat with ab twist
    // ski hops
    // pulse squats into squat jump
    // inch worm with push up
    // reverse lunges with hop
    // moutain climbers
    // burpees
    // pushups
    
    //convert the workout models into data that we'll feed the timer
    //timer countdown and maybe a tag that indicates
    
    //Cool Down
    //stretch out
    
    
    //Other Excercises:
    
    //box jumps
    //ice skaters / ski hops
    //pulse squates into jump
    //inchworm with push-up
    //reverse lunges with hop
    //kettle bell squats / dumbell squats
    //Tricep extensions (diamond pushups)
    //Dumbell squats
    //Rope waves
    //Weight bag squats
    //mountain climbers
    //dual dumbell standing rows
    //jumping jacks
    //high knees
    //wall sits
    //bicycles - abs
    //leg raises
    //
}


//Individual workout activity
struct Exercise {
    var name: String!
    var description: String!
    var targetAreas: [TargetArea]!
    var difficulty: Difficulty!
}

//Difficulty level of activities
enum Difficulty: Int {
    case Easy = 1
    case Medium = 2
    case Hard = 3
}

//Potential muscle groups that workouts may engage
enum TargetArea: String {
    case Abs = "Abs"
    case Arms = "Arms"
    case Shoulders = "Shoulders"
    case Biceps = "Biceps"
    case Triceps = "Triceps"
    case Chest = "Chest"
    case Back = "Back"
    case Obliques = "Obliques"
    case Legs = "Legs"
    
    //TODO: might get rid of specific leg exercises
    case Glutes = "Glutes"
    case Quads = "Quads"
    case Hamstring = "Hamstring"
    case Cardio = "Cardio"
    case Core = "Core"
}
