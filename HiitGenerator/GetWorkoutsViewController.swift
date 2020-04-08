//
//  GetWorkoutsViewController.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/6/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import UIKit

class GetWorkoutsViewController: UIViewController {

    @IBOutlet weak var workoutsTable: UITableView!
    
    @IBAction func didPressGetWorkouts(_ sender: Any) {
        WorkoutDataModels.getAllExercises { (snapshot_opt, error_opt) in
            if let _ = error_opt {
                // TODO: Handle Error
            } else {
                let collection = snapshot_opt!.documents.map({ (document_snapshot) -> Exercise in
                    guard let exercise = Exercise(fromData: document_snapshot.data(), id: document_snapshot.documentID) else {
                        fatalError("Struct init returned nil. Check incoming data")
                    }
                    return exercise
                })
                
                self.dataSource = collection
            }
        }
    }
    
    var dataSource: [Exercise] = [] {
        didSet{
            self.workoutsTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.workoutsTable.delegate = self
        self.workoutsTable.dataSource = self
        self.workoutsTable.register(UITableViewCell.self, forCellReuseIdentifier: "normal_cell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "view_workout" {
            guard let vc = segue.destination as? ShowWorkoutViewController,
                let indexPath = sender as? IndexPath else { return }
            vc.exercise = self.dataSource[indexPath.row]
        }
    }
}

extension GetWorkoutsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "normal_cell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = self.dataSource[indexPath.row].name
        return cell
    }
    
    
}

extension GetWorkoutsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "view_workout", sender: indexPath)
    }
}
