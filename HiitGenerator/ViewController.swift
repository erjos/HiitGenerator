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

    override func viewDidLoad() {
        super.viewDidLoad()
        setView(.Stopped)
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
}
