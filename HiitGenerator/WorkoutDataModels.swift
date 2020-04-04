//
//  WorkoutDataModels.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 11/30/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//
import Foundation
import FirebaseFirestore

class WorkoutDataModels {
    
    struct Exercise {
        var name: String
        var description: String
        var instructions: [String]
        var workoutTypes: [WorkoutTypes]
        var difficulty: Difficulty
    }
    
    enum WorkoutTypes: String {
        case Arms = "Arms"
        case Shoulders = "Shoulders"
        case Biceps = "Biceps"
        case Triceps = "Triceps"
        case Chest = "Chest"
        case Back = "Back"
        case Legs = "Legs"
        case Cardio = "Cardio"
        case Core = "Core"
    }
    
    
    // Need a way to edit these instructions
    
    //Solution would be to create a CMS for the workouts on the client to edit and add.
    
    let jumpSquat = ["name" : "Jump Squat",
                     "description" : "Normal squat with an explosive ending.",
                     "instructions" : ["Begin with your feet shoulder width apart.",
                                       "Sit back into a squat position, breaking at the hips first.",
                                       "Extend upwards into a jump. Repeat."],
                     "workout_types" : ["cardio","legs","core"],
                     "difficulty" : "medium"] as [String: Any]
    
    let moutainClimber = ["name" : "Mountain Climber",
                          "description" : "Full-body core exercise",
                          "instructions" : ["Start in a plank position.",
                                            "Keeping the rest of your body stationary, bend one leg at the knee bringing it up to your chest.",
                                            "Alternate between legs."],
                          "workout_types" : ["cardio","core","arms"],
                          "difficulty" : "medium"] as [String: Any]
    
    let burpee = ["name" : "Burpee",
                  "description" : "Combination of a plank and a squat jump.",
                  "instructions" : ["Bend at the knees and plant your hands on the ground.","Jump your feet back moving into a plank position.","Jump you feet back up to your hands and perform a jump squat."],
                  "workout_types" : ["cardio","core","legs"],
                  "difficulty" : "medium"] as [String: Any]
    
    let inchworm = ["name" : "Inchworm",
                    "description" : "",
                    "instructions" : ["","",""],
                    "workout_types" : ["","",""],
                    "difficulty" : "medium"] as [String: Any]
    
    let lungeJump = ["name" : "Lunge Jump",
                     "description" : "",
                     "instructions" : ["","",""],
                     "workout_types" : ["","",""],
                     "difficulty" : "medium"] as [String: Any]
    
    let toeTap = ["name" : "Toe Tap",
                  "description" : "",
                  "instructions" : ["","",""],
                  "workout_types" : ["","",""],
                  "difficulty" : "easy"] as [String: Any]
    
    let jumpingJack = ["name" : "Jumping Jack",
                       "description" : "",
                       "instructions" : ["","",""],
                       "workout_types" : ["","",""],
                       "difficulty" : "easy"] as [String: Any]
    
    let skater = ["name" : "Skater",
                  "description" : "",
                  "instructions" : ["","",""],
                  "workout_types" : ["","",""],
                  "difficulty" : "medium"] as [String: Any]
    
    let skiHop = ["name" : "Ski Hop",
                 "descriptio n" : "",
                 "instructions" : ["","",""],
                 "workout_types" : ["","",""],
                 "difficulty" : "medium"] as [String: Any]
    
    let squatAbTwist = ["name" : "Squat with Ab Twist",
                        "description" : "",
                        "instructions" : ["","",""],
                        "workout_types" : ["","",""],
                        "difficulty" : "medium"] as [String: Any]
    
    let sideShuffle = ["name" : "Side Shuffle",
                       "description" : "",
                       "instructions" : ["","",""],
                       "workout_types" : ["","",""],
                       "difficulty" : "easy"] as [String: Any]
    
    let highKnees = ["name" : "High Knee",
                     "description" : "",
                     "instructions" : ["","",""],
                     "workout_types" : ["","",""],
                     "difficulty" : "medium"] as [String: Any]
    
    let jumpRope = ["name" : "Jump Rope",
                    "description" : "",
                    "instructions" : ["","",""],
                    "workout_types" : ["","",""],
                    "difficulty" : "medium"] as [String: Any]
    
    let mountainClimberTwist = ["name" : "Mountain Climbers with Twist",
                                "description" : "",
                                "instructions" : ["","",""],
                                "workout_types" : ["","",""],
                                "difficulty" : ""] as [String: Any]
    
    let plankKneeTap = ["name" : "Plank Knee Tap",
                        "description" : "",
                        "instructions" : ["","",""],
                        "workout_types" : ["","",""],
                        "difficulty" : ""] as [String: Any]
    
    let longJumpJogBack = ["name" : "Long Jump with Jog Back",
                           "description" : "",
                           "instructions" : ["Keeping your feet together, take a long jump forward.","After you land, jog backwards to your starting position.","Repeat."],
                           "workout_types" : ["Cardio","Legs"],
                           "difficulty" : "medium"] as [String: Any]
    
    "Step Up"
    "Reverse Lunge with Hop"
    "Triceps Pushup with Mountain Climber"
    "Donkey Kick"
    "Pushup with Knee Touch"
    "Burpee with Pushup"
    
    func createExerciseCollection(collection: [Exercise]) {
        
        for exercise in collection {
            writeDataToFirestore(exercise: exercise)
        }
    }
    
    func writeDataToFirestore(exercise: Exercise) {
        
        // Adds document and generates UUID automatically
        let workout_types_array = exercise.workoutTypes.map { (type) -> String in
            return type.rawValue
        }
        
        let exercise_data = ["name": exercise.name,
                             "description": exercise.description,
                             "instructions": exercise.instructions,
                             "workout_types": workout_types_array,
                             "difficulty": exercise.difficulty] as [String : Any]
        let _ = Firestore.firestore().collection("exercises").addDocument(data: exercise_data) { (error_optional) in
            // TODO: add error handler and any completion actions
        }
    }
    
    
    //Warm Up
    //jumping jacks, squats, scoops, lunges, inchworms, leg raises
    //short run?
    
    //Workout 1 : Arms, Chest, Core, Legs
    //let shoulderPress = Exercise(name: "Shoulder Press", description: "Raise two dumbells (one in each hand) above your head repeatedly. Start with your arms bent at chest level and lift the dumbells up as you straighten your arms. Be sure to keep your core tight while performing this excercise.", targetAreas: [.Shoulders, .Arms], difficulty: .Medium)
    
    //let pushups = Exercise(name: "Pushups", description: "Start on the ground in plank position. Bend your arms to lower your chest to the ground. Straighten your arms and return to plank position. Repeat. To make this excercise easier, place your knees on the ground.", targetAreas: [.Chest, .Core, .Arms], difficulty: .Easy)
    
    //let jumpSquats = Exercise(name: "Jump-squat", description: "Stand square with feet shoulder width apart. Lower your waist back as if you were sitting in a chair and come to a complete squat position. Be sure to keep your weight back and on your heels and make sure your knees don't cross the plane of your toes. Explode upwards as you straighten your legs and jump into the air.", targetAreas: [.Legs], difficulty: .Easy)
    
    //Workout 2 : Abs, Legs, Biceps
    //let shoulderTaps = Exercise(name: "Should taps", description: "Start in plank position. One at a time tap your shoulders with the opposite arm. Keep your core tight and try not to rotate your body when you go to one arm.", targetAreas: [.Core, .Abs, .Arms], difficulty: .Medium)
    
    //let splitLunges = Exercise(name: "Split Lunges", description: "Drop one leg back into a deep lunge position. Return to neutral and repeat with opposite leg.", targetAreas: [.Legs], difficulty: .Medium)
    
    //let bicepCurl = Exercise(name: "Bicep Curl", description: "Using dumbell, barbell or tension cords complete bicep curls simultaneously in right and left arms with a light weight. Focus on form and isolating your bicep", targetAreas: [.Arms, .Biceps], difficulty: .Easy)
    
    //Workout 3 : Chest, Legs, Abs, Cardio
    //let burpee = Exercise(name: "Burpee", description: "Start standing. Drop down into plank position. Do a pushup. Return to start and jump in the air. Focus on swift transitions between the postions. You should be moving fluidly between the positions. To make this excercise easier, don't do a jump at the end, just return to your starting position.", targetAreas: [.Chest, .Core, .Legs], difficulty: .Medium)
    //Not sure if that's the correct name for this
    //let downUps = Exercise(name: "Down/Ups", description: "Start in plank position. One arm at a time move from your hand to your elbow plank position. Then move back to your hand position in the reverse order.", targetAreas: [.Core, .Abs], difficulty: .Easy)
    //let runUps = Exercise(name: "Run ups", description: "Using a platform, place one foot on the platform and rapidly remove it, replacing it with the opposite foot. This should create a running motion as you switch which foot is on the platform.", targetAreas: [.Legs, .Cardio], difficulty: .Easy)
    
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



enum Difficulty: Int {
    case Easy = 1
    case Medium = 2
    case Hard = 3
}
