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
    
    //not sure what we need to use this for yet
    weak var delegate : DrawerMenuDelgate?
    private let CELL_REUSE_ID = "menuCell"
    
    //eventually we want this view to contain the table view that represents the menu
    var menuDisplay: UITableView?
    
    //initializes the display and sets up datasource/delegate
    func setupDisplay() {
        guard menuDisplay == nil else {
            return
        }
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
        //let gestureIsDraggingFromLeftToRight = (gesture.velocity(in: view).x > 0)
        switch gesture.state {
        case .began:
            print("began")
        case .changed:
            if let _ = gesture.view {
                //create method to set the display width
                self.menuDisplay?.frame = CGRect(x: 0, y: 0, width: (self.menuDisplay?.frame.width)! + gesture.translation(in: self.superview).x, height: (self.menuDisplay?.frame.height)!)
                //self.menuCoverWidth.constant = UIScreen.main.bounds.width - self.menuWidth.constant
                gesture.setTranslation(CGPoint.zero, in: superview)
            }
            //implements logic to determine if menu should remain open or closed
        case .ended:
            print("ended")
//                if gestureIsDraggingFromLeftToRight {
//                    let hasMovedGreaterThanHalfway = menuWidth.constant > 150
//
//                    if (hasMovedGreaterThanHalfway) {
//                        self.openMenu()
//                    } else {
//                        self.closeMenu()
//                    }
//                } else {
//                    let hasMovedGreaterThanHalfway = menuWidth.constant < 150
//                    if (hasMovedGreaterThanHalfway) {
//                        self.closeMenu()
//                    } else {
//                        self.openMenu()
//                    }
//                }
            default:
                break
        }
    }
}

extension DrawerMenu: UITableViewDataSource {
    //handles table setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
    }
}

extension DrawerMenu: UITableViewDelegate {
    //handles passing the table selection to the delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}

//maybe this'll make it more obvious that we need to implement the pan gesture when using this control
@objc protocol DrawerMenuDelgate : class {
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer)
}
