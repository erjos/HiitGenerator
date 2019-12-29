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
    
    weak var gestureDelegate : DrawerGestureDelegate?
    weak var delegate: DrawerMenuDelegate?
    
    private var menuBuilder = MenuDisplay()
    private lazy var menuView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private var isDisplayAdded = false
    
    private func addDisplayToView() {
        guard !isDisplayAdded else { return }
        self.superview?.addSubview(menuView)
        isDisplayAdded = true
        menuView.backgroundColor = .darkGray
    }
    
    //document this function
    func loadMenu() {
        menuBuilder.setMenuData(delegate?.setDataSource(drawerMenu: self))
        menuView.reloadData()
    }
    
    func getPanGesture() -> UIPanGestureRecognizer {
        return UIPanGestureRecognizer(target: gestureDelegate, action: #selector(gestureDelegate?.handlePanGesture(_:)))
    }
    
    private func openMenu() {
        addDisplayToView()
        UIView.animate(withDuration: 0.2) {
            self.menuView.frame = CGRect(x: 0, y: 0, width: 300, height: (self.superview?.frame.height)!)
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func closeMenu() {
        UIView.animate(withDuration: 0.2) {
            self.menuView.frame = CGRect(x: 0, y: 0, width: 0, height: (self.superview?.frame.height)!)
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
        self.menuBuilder.setup(menuView)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DrawerMenu.didTap(_:))))
        
        let menuImage = UIImage(named: "menu_black")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        imageView.image = menuImage
        self.addSubview(imageView)
        self.loadMenu()
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        openMenu()
    }
    
    /**
      * This function handles the gesture logic for the standard sliding drawer behavior. Implement this method in the DrawerGestureDelegate to handle the gesture added on the view where the menu lives.
     - Parameters:
        - gesture: The pan gesture on the view, which controls the menu.
    */
    func handleGesture(_ gesture: UIPanGestureRecognizer) {
        addDisplayToView()
        let gestureIsDraggingFromLeftToRight = (gesture.velocity(in: superview).x > 0)
        switch gesture.state {
        case .began:
            print("began")
        case .changed:
            if let _ = gesture.view {
                //create method to set the display width
                self.menuView.frame = CGRect(x: 0, y: 0, width: (self.menuView.frame.width) + gesture.translation(in: superview).x, height: ((self.superview?.frame.height)!))
                
                //self.menuCoverWidth.constant = UIScreen.main.bounds.width - self.menuWidth.constant
                gesture.setTranslation(CGPoint.zero, in: superview)
            }
            //implements logic to determine if menu should remain open or closed
        case .ended:
            if gestureIsDraggingFromLeftToRight {
                let hasMovedGreaterThanHalfway = (menuView.frame.width) > 150
                if (hasMovedGreaterThanHalfway) {
                    self.openMenu()
                } else {
                    self.closeMenu()
                }
            } else {
                let hasMovedGreaterThanHalfway = (menuView.frame.width) < 150
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

@objc protocol DrawerGestureDelegate : class {
    /**
      * Handles the pan gesture from the view controller where the menu exists. ViewControllers that implement this method should call the handleGesture(_ gesture: UIPanGestureRecognizer) function on the DrawerMenu and getPanGesture(target: DrawerGestureDelegate) -> UIPanGestureRecognizer to create and add the pan gesture to their view.
     - Parameters:
        - gesture: The pan gesture recognizer that is generated from the getPanGesture method on the DrawerMenu
    */
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer)
}

protocol DrawerMenuDelegate: class {
    
    /**
      * Sets the data source for the menu, implementation should return MenuDataObject. Can be used to reconfigure menu properites when the data source is changed or updated.
     - Parameters:
        - drawerMenu: The menu object that is requesting a new data source.
    */
    func setDataSource(drawerMenu: DrawerMenu)-> MenuData
}
