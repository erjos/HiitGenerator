//
//  DrawerMenu.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 12/27/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import Foundation
import UIKit.UIControl
import UIKit.UIGestureRecognizerSubclass

class DrawerMenu: UIControl {
    
    //not sure what we need to use this for yet
    weak var delegate : DrawerMenuDelgate?
    
    //eventually we want this view to contain the table view that represents the menu
    var menuDisplay: UIView?
    
    func setupDisplay() {
        guard menuDisplay == nil else {
            return
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .purple
        self.menuDisplay = view
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
        //handle the gesture... will this get called if we drop the gesture on the main page?
        setupDisplay()
        self.menuDisplay?.backgroundColor = self.menuDisplay?.backgroundColor == .purple ? .red : .purple
    }
}

//maybe this'll make it more obvious that we need to implement the pan gesture when using this control
@objc protocol DrawerMenuDelgate : class {
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer)
}
