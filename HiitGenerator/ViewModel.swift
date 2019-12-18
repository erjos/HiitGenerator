//
//  ViewModel.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 12/1/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import Foundation

enum WorkoutViewState {
    case Active
    case Rest
    case Paused
    case Stopped
}

class ViewModel {
    
    var routine: Routine {
        return WorkoutDataModels().generateRoutine()
    }
    
    var workoutPhases: [(timeInterval: Int, viewState: WorkoutViewState)]!
}
