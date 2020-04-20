//
//  WorkoutTimer.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/19/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import Foundation

class WorkoutTimer {
    
    private var seconds: Double = 0
    private var timerDevice = Timer()
    
    weak var delegate: WorkoutTimerDelegate?
    
    func runTimer(startTime: Double) {
        timerDevice.invalidate()
        seconds = startTime
        timerDevice = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        timerDevice.invalidate()
    }
    
    func resumeTimer() {
        timerDevice = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //TODO: add way to switch between count up and count down
    @objc func updateTimer() {
        seconds += 1
        self.delegate?.didUpdateTimer(seconds: self.seconds)
    }
}

protocol WorkoutTimerDelegate: class {
    func didUpdateTimer(seconds: Double)
}
