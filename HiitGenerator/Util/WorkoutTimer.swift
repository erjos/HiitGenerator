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
    private var countMode: CountMode = .up
    private var endTime: Double = 0
    
    /// This method starts the timer. Countdown mode defaults to .up and the endTime defaults to greatest finite magnitude.
    func runTimer(startTime: Double, countMode: CountMode = .up, endTime: Double = Double.greatestFiniteMagnitude) {
        self.countMode = countMode
        self.endTime = endTime
        timerDevice.invalidate()
        self.seconds = startTime
        self.timerDevice = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        self.timerDevice.invalidate()
    }
    
    func resumeTimer() {
        self.timerDevice = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func handleTimerUpdate(mode: CountMode) {
        let isUp = (mode == .up)
        let endValue = isUp ? self.endTime : 0
        guard self.seconds != endValue else {
            self.timerDevice.invalidate()
            self.delegate?.didFinishTimer()
            return
        }
        self.seconds = isUp ? seconds + 1 : seconds - 1
    }
    
    @objc func updateTimer() {
        self.handleTimerUpdate(mode: self.countMode)
        self.delegate?.didUpdateTimer(seconds: self.seconds)
    }
}

enum CountMode {
    case up
    case down
}

protocol WorkoutTimerDelegate: class {
    func didUpdateTimer(seconds: Double)
    func didFinishTimer()
}
