//
//  WorkoutDataModels.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 11/30/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//
import Foundation

struct Exercise: Hashable {
    
    var uuid: String
    var name: String
    var description: String
    var instructions: [String]
    var workoutTypes: [WorkoutType]
    var difficulty: Difficulty
    
    init(name: String, description: String, instructions: [String], workoutTypes: [WorkoutType], difficulty: Difficulty) {
        self.uuid = UUID().description
        self.name = name
        self.description = description
        self.instructions = instructions
        self.workoutTypes = workoutTypes
        self.difficulty = difficulty
    }
    
    init?(fromData data: [String: Any], id: String) {
        guard let name = data["name"]as? String,
        let description = data["description"] as? String,
        let instructions = data["instructions"] as? [String],
        let types_array = data["workout_types"] as? [String],
        let difficulty_number = data["difficulty"] as? Int else { return nil }
        
        let types_enum = types_array.map { (string) -> WorkoutType in
            guard let type_enum = WorkoutType(rawValue: string) else { fatalError("Raw value \(string) failed to convert to type WorkoutType.") }
            return type_enum
        }
        
        guard let difficulty = Difficulty(rawValue: difficulty_number) else { return nil }
        
        self.uuid = id
        self.name = name
        self.description = description
        self.instructions = instructions
        self.workoutTypes = types_enum
        self.difficulty = difficulty
    }
}

enum WorkoutType: String, CaseIterable {
    case Arms = "arms"
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

/// Completion that takes an optional error - all optional closures are escaping by default
typealias CompletionOptional = ((Error?)->())?
