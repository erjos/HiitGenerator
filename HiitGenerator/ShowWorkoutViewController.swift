//
//  ViewController.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 11/30/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import UIKit
import DrawerMenu

class ShowWorkoutViewController: UIViewController {
    var viewModel = ViewModel()
    
    //@IBOutlet weak var drawerMenu: DrawerMenu!
    
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var workoutDescription: UILabel!
    @IBOutlet weak var workoutType: UILabel!
    @IBOutlet weak var workoutDifficulty: UILabel!
    
    @IBOutlet weak var timer: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    var exercise: Exercise!
    
    //Not sure I remember what this guy does
    @IBAction func didPress(_ sender: Any) {
        
    }
    
    var menuItems = ["Log In", "Settings", "My Workouts", "Disclaimer", "About the App"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPage(exercise: self.exercise)
        setView(.Stopped)
        
        //self.runTimer()
        
        //drawerMenu.delegate = self
        //drawerMenu.loadMenu()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit_exercise",
            let vc = segue.destination as? CreateExerciseViewController {
            vc.exercise = self.exercise
        }
        
        if segue.identifier == "new_exercise" {
            
        }
    }
    
    func setupPage(exercise: Exercise) {
        self.workoutName.text = exercise.name
        self.workoutDescription.text = exercise.description
        self.workoutType.text = exercise.workoutTypes.map{$0.rawValue}.joined(separator: " - ")
        self.workoutDifficulty.text = String(exercise.difficulty.rawValue)
    }
    
    func setExerciseInfo(_ exercise: Exercise) {
        workoutName.text = exercise.name
        workoutDescription.text = exercise.description
        //workoutType.text = exercise.targetAreas.compactMap({ targetArea -> String in targetArea.rawValue })
            //.joined(separator: ", ")
    }
    
    //IDK if we'll end up using this
    fileprivate func setView(_ state: WorkoutViewState) {
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

extension ShowWorkoutViewController: MenuInteractorDelegate {
    func didSelectItem(indexPath: IndexPath, label: String) {
        //handle select
    }
    
    func didPressBack() {
        //handle back press
    }
    
    func didDeleteItem(indexPath: IndexPath, label: String) {
        //delete item from data source
    }
    
    //Consider how we want to trigger this to update
    func setDataSource(drawerMenu: DrawerMenu) -> MenuData {
        return MenuData("Menu", menuItems)
    }
}
