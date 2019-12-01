//
//  ViewController.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 11/30/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate enum WorkoutState {
        case Active
        case Rest
        case Paused
        case Stopped
    }
    
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var workoutDescription: UILabel!
    @IBOutlet weak var workoutType: UILabel!
    @IBOutlet weak var workoutDifficulty: UILabel!
    
    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func didPress(_ sender: Any) {
    }
    
    //var workout:

    override func viewDidLoad() {
        super.viewDidLoad()
        setView(.Stopped)
        self.runTimer()
    }
    
    fileprivate func setView(_ state: WorkoutState) {
        switch state {
        case .Active:
            setActive()
        case .Paused:
            setPaused()
        case .Rest:
            setRest()
        case .Stopped:
            setStopped()
        }
    }
    
    private func setActive() {
        //set view to active
    }
    
    private func setPaused() {
        //set view to paused
    }
    
    private func setRest() {
        //set view to active
    }
    
    private func setStopped() {
        //set view to stopped
    }
    
    var seconds:Double = 0
    var timerDevice = Timer()
    
    //All these timer methods modify variables on the page - consider moving them to their own method
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    @objc func updateTimer() {
        seconds += 1
        timer.text = "\(timeString(time: seconds))"
    }
    
    func runTimer() {
        timerDevice.invalidate()
        seconds = 0
        timerDevice = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
}
