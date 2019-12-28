//
//  DrawerMenu.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 12/27/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import Foundation
import UIKit

class DrawerMenu: UIControl {
    
    weak var delegate : DrawerMenuDelgate?
    private let CELL_REUSE_ID = "menuCell"
    let HEADER_HEIGHT = 75
    let CELL_HEIGHT = 44
    let HEADER_VIEW = "DrawerHeaderView"
    
    //eventually we want this view to contain the table view that represents the menu
    var menuDisplay: UITableView?
    
    //initializes the display and sets up datasource/delegate
    func setupDisplay() {
        guard menuDisplay == nil else { return }
        menuDisplay?.delegate = self
        menuDisplay?.dataSource = self
        menuDisplay?.register(UITableViewCell.self, forCellReuseIdentifier: CELL_REUSE_ID)
        
        guard let parent = self.superview else { return }
        
        self.menuDisplay = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: parent.frame.height))
        self.superview?.addSubview(menuDisplay!)
    }
    
    func getPanGesture(target: DrawerMenuDelgate) -> UIPanGestureRecognizer {
        self.delegate = target
        return UIPanGestureRecognizer(target: delegate, action: #selector(delegate?.handlePanGesture(_:)))
    }
    
    
    //might be able to combine these
    func openMenu() {
        UIView.animate(withDuration: 0.2) {
            self.menuDisplay?.frame = CGRect(x: 0, y: 0, width: 300, height: (self.menuDisplay?.frame.height)!)
            self.superview?.layoutIfNeeded()
        }
    }
    func closeMenu() {
        UIView.animate(withDuration: 0.2) {
            self.menuDisplay?.frame = CGRect(x: 0, y: 0, width: 0, height: (self.menuDisplay?.frame.height)!)
            self.superview?.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      commonInit()
    }

    private func commonInit() {
      backgroundColor = .blue
    }
    
    //call this function from the handlePanGesture delegate function to allow interaction with the menu from any class
    func handleGesture(_ gesture: UIPanGestureRecognizer) {
        setupDisplay()
        //might not need this unwrapped here
        //guard let parent = self.superview else { print("no superview") ; return }
        
        let gestureIsDraggingFromLeftToRight = (gesture.velocity(in: superview).x > 0)
        switch gesture.state {
        case .began:
            print("began")
        case .changed:
            if let _ = gesture.view {
                //create method to set the display width
                self.menuDisplay?.frame = CGRect(x: 0, y: 0, width: (self.menuDisplay?.frame.width)! + gesture.translation(in: superview).x, height: (self.menuDisplay?.frame.height)!)
                
                //self.menuCoverWidth.constant = UIScreen.main.bounds.width - self.menuWidth.constant
                gesture.setTranslation(CGPoint.zero, in: superview)
            }
            //implements logic to determine if menu should remain open or closed
        case .ended:
            if gestureIsDraggingFromLeftToRight {
                let hasMovedGreaterThanHalfway = (menuDisplay?.frame.width)! > 150
                if (hasMovedGreaterThanHalfway) {
                    self.openMenu()
                } else {
                    self.closeMenu()
                }
            } else {
                let hasMovedGreaterThanHalfway = (menuDisplay?.frame.width)! < 150
                if (hasMovedGreaterThanHalfway) {
                    self.closeMenu()
                } else {
                    self.openMenu()
                }
            }
        default:
            break
        }
    }
}

extension DrawerMenu: UITableViewDataSource {
    //handles table setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //make this dynamic
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_ID, for: indexPath)
        //configure cell
        return cell
    }
}

extension DrawerMenu: UITableViewDelegate {
    //handles passing the table selection to the delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //pass relevant data into the delegate method
    }
}

//maybe this'll make it more obvious that we need to implement the pan gesture when using this control
@objc protocol DrawerMenuDelgate : class {
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer)
}
