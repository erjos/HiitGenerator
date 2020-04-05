//
//  WorkoutDataModels.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 11/30/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//
import Foundation
import FirebaseFirestore

// App concept:
//Barebones simplified way to generate randomized minimalist workouts.

//Themes
//Could utilize the retro, analog vibes of a classic no frills gym

class WorkoutDataModels {
    
    struct Exercise {
        var name: String
        var description: String
        var instructions: [String]
        var workoutTypes: [WorkoutType]
        var difficulty: Difficulty
    }
    
    //TODO: other beneficial pieces of data:
    //tips/pointers - // modifications?
    //equipment needed - to adapt to what users may have on hand
    
    enum WorkoutType: String {
        case Arms = "arms"
        case Shoulders = "shoulders"
        case Biceps = "biceps"
        case Triceps = "triceps"
        case Chest = "chest"
        case Back = "back"
        case Legs = "legs"
        case Cardio = "cardio"
        case Core = "core"
    }
    
    /// Exercise difficulty and complexity scale with 1 being the easiest
    enum Difficulty: Int {
        case One = 1
        case Two
        case Three
    }
    
    enum Equipment: String {
        case ResistanceBands
        case PullupBar
        case Dumbells
        case KettleBells
        case JumpRope
        case BoxJump //could be any sturdy surface or bench
    }

    
    // Need a way to edit these instructions and add new ones
    
    //Solution would be to create a CMS for the workouts on the client to edit and add.
    
    let jumpSquat = ["name" : "Jump Squat",
                     "description" : "Normal squat with an explosive ending.",
                     "instructions" : ["Begin with your feet shoulder width apart.",
                                       "Sit back into a squat position, breaking at the hips first.",
                                       "Extend upwards into a jump. Repeat."],
                     "workout_types" : ["cardio",
                                        "legs",
                                        "core"],
                     "difficulty" : 2] as [String: Any]
    
    let moutainClimber = ["name" : "Mountain Climber",
                          "description" : "Full-body core exercise.",
                          "instructions" : ["Start in a plank position.",
                                            "Keeping the rest of your body stationary, bend one leg at the knee bringing it up to your chest.",
                                            "Alternate between legs."],
                          "workout_types" : ["cardio",
                                             "core",
                                             "arms"],
                          "difficulty" : 2] as [String: Any]
    
    let squatThrust = ["name" : "Squat Thrust",
                  "description" : "Combination of a plank and a squat jump.",
                  "instructions" : ["Bend at the knees and plant your hands on the ground.",
                                    "Jump your feet back moving into a plank position.",
                                    "Jump your feet back up to your hands and perform a jump squat raising your hands above your head."],
                  "workout_types" : ["cardio",
                                     "core",
                                     "legs"],
                  "difficulty" : 2] as [String: Any]
    
    let inchworm = ["name" : "Inchworm",
                    "description" : "Great core workout or warmup.",
                    "instructions" : ["Bend at the waist, placing your hands on the ground.",
                                      "Using your hands, walk yourself out until you reach plank position.",
                                      "Walk yourself back to your starting position."],
                    "workout_types" : ["core",
                                       "arms"],
                    "difficulty" : 2] as [String: Any]
    
    let lungeJump = ["name" : "Lunge Jump",
                     "description" : "Advanced plyometric version of the basic lunge.",
                     "instructions" : ["Begin by stepping one leg forward into a lunge.",
                                       "Explode upwards into a jump.",
                                       "Switch your feet before you land entering a lunge with the opposite foot."],
                     "workout_types" : ["cardio",
                                        "legs"],
                     "difficulty" : 3] as [String: Any]
    
    let toeTap = ["name" : "Toe Tap",
                  "description" : "Gets the heart pumping.",
                  "instructions" : ["Use a sturdy surface around knee height or below.",
                                    "Bring the toe of your foot onto the surface until it lightly touches.",
                                    "Rapidly return your foot to starting position and switch feet, creating a running motion."],
                  "workout_types" : ["cardio",
                                     "legs"],
                  "difficulty" : 1] as [String: Any]
    
    let jumpingJack = ["name" : "Jumping Jack",
                       "description" : "A gymclass favorite.",
                       "instructions" : ["Do a jumping jack."],
                       "workout_types" : ["cardio"],
                       "difficulty" : 1] as [String: Any]
    
    let skater = ["name" : "Skater",
                  "description" : "Skate in place, jump side-to-side. Great for strength and agility.",
                  "instructions" : ["Ensure you have room to jump side to side. Crouch down with your one leg reaching the opposite leg out behind you for balance while coming across your body to touch your foot. ",
                                    "Jump sideways off your crouched foot onto your other leg and bend the knee to absorb the impact.",
                                    "Ensure your are balanced and steady, then repeat."],
                  "workout_types" : ["cardio",
                                     "legs"],
                  "difficulty" : 2] as [String: Any]
    
    let squatAbTwist = ["name" : "Squat with Ab Twist",
                        "description" : "Normal squat with a twist to help engage the abs.",
                        "instructions" : ["Start with feet shoulder width apart.",
                                          "Sit back in a squat and extend upwards engaging your legs.",
                                          "When you reach the top of your squat tighten your abs to bring one knee up and touch the opposite elbow. Repeat."],
                        "workout_types" : ["cardio",
                                           "legs",
                                           "core"],
                        "difficulty" : 2] as [String: Any]
    
    let sideShuffle = ["name" : "Side Shuffle",
                       "description" : "A simple exercise to elevate the heart-rate.",
                       "instructions" : ["Ensure you have enough room on either side.",
                                         "Step out to the side with one foot shuffling your opposite foot in to touch the inside of your stepping foot.",
                                         "Repeat in the opposite direction."],
                       "workout_types" : ["cardio"],
                       "difficulty" : 1] as [String: Any]
    
    let highKnees = ["name" : "High Knee",
                     "description" : "Reminds me of soccer practice.",
                     "instructions" : ["Raise your knees straight up in the air.",
                                       "Alternate quickly, driving each knee high into the air.",
                                       "Repeat."],
                     "workout_types" : ["cardio",
                                        "legs"],
                     "difficulty" : 2] as [String: Any]
    
    let jumpRope = ["name" : "Jump Rope",
                    "description" : "Classic, what can I say.",
                    "instructions" : ["Jump some rope","",""],
                    "workout_types" : ["cardio"],
                    "difficulty" : 2] as [String: Any]
    
    let mountainClimberTwist = ["name" : "Mountain Climbers with Twist",
                                "description" : "Mountain climbers with added ab twist for difficulty.",
                                "instructions" : ["Similar to a normal mountain climber begin in plank position.",
                                                  "Bring your knee up to the opposite elbow.",
                                                  "Repeat with opposite side."],
                                "workout_types" : ["cardio",
                                                   "core",
                                                   "arms"],
                                "difficulty" : 3] as [String: Any]
    
    let plankKneeTap = ["name" : "Plank Knee Tap",
                        "description" : "As if planks weren't hard enough.",
                        "instructions" : ["Start in the plank position.",
                                          "Bending at the waist, while keeping your back straight, bring one arm down and tap the opposite knee.",
                                          "Extend at the waist returning to a normal plank position and repeat with the opposite side."],
                        "workout_types" : ["cardio",
                                           "core",
                                           "arms"],
                        "difficulty" : 3] as [String: Any]
    
    let longJumpJogBack = ["name" : "Long Jump with Jog Back",
                           "description" : "Great for legs and cardio.",
                           "instructions" : ["Keeping your feet together, take a long jump forward.",
                                             "After you land, jog backwards to your starting position.",
                                             "Repeat."],
                           "workout_types" : ["cardio",
                                              "legs"],
                           "difficulty" : 2] as [String: Any]
    
    let plankJacks = ["name" : "Plank Jack",
                      "description" : "Simple modification to the plank to increase cardio and core engagement.",
                      "instructions" : ["Start in a normal plank position.",
                                        "At the same time jump both of your feet outwards into a wide stance.",
                                        "Pause briefly before quickly jumping them back in. Repeat"],
                      "workout_types" : ["cardio",
                                         "core",
                                         "arms"],
                      "difficulty" : 2 ] as [String: Any]
    
    let reverseLungeHop = ["name" : "Reverse Lunge with Hop",
                           "description" : "Another plyometric variation of the lunge.",
                           "instructions" : ["Step one foot backwards engaging your front leg in a traditional lunge.",
                                             "When you reach the bottom of your lunge, extend upwards bringing your back knee into the air and ending with a hop.",
                                             "Repeat with the other leg."],
                           "workout_types" : ["cardio",
                                              "core",
                                              "legs"],
                           "difficulty": 2 ] as [String: Any]
    
    let shoulderTaps = ["name" : "Shoulder Tap",
                        "description" : "Core with something extra for the arms.",
                        "instructions" : ["Start in a standard plank position",
                                          "Lift one hand off the ground, and tap your opposite shoulder.",
                                          "Place your hand back on the ground and repeat with the opposite side"],
                        "workout_types" : [ "core",
                                            "arms"],
                        "difficulty" : 2] as [String: Any]
    
    let pushup = ["name" : "Pushup",
                  "description" : "Ever heard of it?",
                  "instructions" : ["Do a pushup."],
                  "workout_types": ["core",
                                    "arms"],
                  "difficulty" : 2] as [String: Any]
    
    let inchwormPushup = ["name" : "Inchworm with Pushup",
                          "description" : "Normal inchworm with a pushup added.",
                          "instructions" : ["Bend at the waist, placing your hands on the ground.",
                                            "Using your hands, walk yourself out until you reach plank position and then do a pushup.",
                                            "Walk yourself back to your starting position and repeat."],
                          "workout_types" : ["core",
                                             "arms"],
                          "difficulty" : 3] as [String: Any]
    
    let burpee = ["name" : "Burpee",
                  "description" : "Combination of a plank, pushup and a squat jump.",
                  "instructions" : ["Bend at the knees and plant your hands on the ground.",
                                    "Jump your feet back moving into a plank position and do a pushup.",
                                    "Jump your feet back up to your hands and perform a jump squat raising your hands above your head. Repeat."],
                  "workout_types" : ["cardio",
                                     "core",
                                     "legs"],
                  "difficulty" : 3] as [String: Any]
    
    
    
    
//    "Step Up"
//    "Triceps Pushup with Mountain Climber"
//    "Donkey Kick"
//    "Pushup with Knee Touch"
//    "Plank with Knee Dips"
    
    
//    "Box Jumps"
    
    func createExerciseCollection(collection: [[String: Any]]) {
        
        let firestore = Firestore.firestore()
        
        for exercise_data in collection {
            firestore.collection("exercise").addDocument(data: exercise_data) { (error_optional) in
                if let _ = error_optional {
                    // TODO: handle error
                }
                // TODO: completion actions
            }
        }
    }
    
    /// Stores excercise data model in firestore as a new document
    func writeExerciseToFirestore(exercise: Exercise) {
        
        // Adds document and generates UUID automatically
        let workout_types_array = exercise.workoutTypes.map { (type) -> String in
            return type.rawValue
        }
        
        let exercise_data = ["name": exercise.name,
                             "description": exercise.description,
                             "instructions": exercise.instructions,
                             "workout_types": workout_types_array,
                             "difficulty": exercise.difficulty] as [String: Any]
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
