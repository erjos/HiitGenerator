//
//  DrawerMenu.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 12/27/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import Foundation
import UIKit

//fix the bezier path for the shadow
//fix the force unwraps

//make menu width dynamic based on screen size

class DrawerMenu: UIControl {
    
    //expose open/close functions
    weak var gestureDelegate : DrawerGestureDelegate?
    
    weak var delegate: MenuInteractorDelegate? {
        get {
            return menuInteractor.delegate
        }
        set {
            menuInteractor.delegate = newValue
        }
    }
    
    private var menuInteractor = MenuInteractor()
    private lazy var menuView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private lazy var coverView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private lazy var shadowView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    private let menuWidth:CGFloat = 300
    private let shadowWidth:CGFloat = 5
    
    private var isDisplayAdded = false
    
    private func setupDisplay() {
        guard !isDisplayAdded else { return }
        self.superview?.addSubview(shadowView)
        self.superview?.addSubview(menuView)
        self.superview?.addSubview(coverView)
        isDisplayAdded = true
        
        //COVER VIEW
        coverView.backgroundColor = .clear
        coverView.alpha = 0.5
        coverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCoverTap(_:))))
        
        //MENU VIEW STYLING
        menuView.backgroundColor = .darkGray
        menuView.separatorStyle = .singleLine
        menuView.separatorColor = .black
        menuView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //SHADOW VIEW
        shadowView.backgroundColor = .black
        shadowView.dropShadow()
    }
    
    /**
      * Call this function if you want to reload the menu data or change the menu data source. It will trigger the setDataSource(drawerMenu: DrawerMenu)-> MenuData delegate function.
    */
    func loadMenu() {
        //triggers delegate function on menu interactor to retrieve the data source from the delegate
        menuInteractor.setMenuData(self)
        menuView.reloadData()
    }
    
    /**
      * Returns a pan gesture that is used to open and close the menu. Add it to the view that is responsible for displaying the menu and implement the MenuGestureDelegate to handle the selector.
    */
    func getPanGesture() -> UIPanGestureRecognizer {
        return UIPanGestureRecognizer(target: gestureDelegate, action: #selector(gestureDelegate?.handlePanGesture(_:)))
    }
    
    private func openMenu() {
        setupDisplay()
        UIView.animate(withDuration: 0.2) {
            
            
            self.menuView.frame = CGRect(x: 0, y: 0, width: self.menuWidth, height: (self.superview?.frame.height)!)
            self.shadowView.frame = CGRect(x: (self.menuWidth - self.shadowWidth), y: 0, width: self.shadowWidth, height: (self.superview?.frame.height)!)
            self.coverView.frame = CGRect(x: self.menuWidth, y: 0, width: (self.superview?.frame.width)! - self.menuWidth, height: (self.superview?.frame.height)!)
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func closeMenu() {
        UIView.animate(withDuration: 0.2) {
            self.menuView.frame = CGRect(x: 0, y: 0, width: 0, height: (self.superview?.frame.height)!)
            self.shadowView.frame = CGRect(x: 0, y: 0, width: 0, height: (self.superview?.frame.height)!)
            self.coverView.frame = CGRect(x: 0, y: 0, width: 0, height: (self.superview?.frame.height)!)
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
        self.menuInteractor.setup(menuView)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DrawerMenu.didTap(_:))))
        
        let menuImage = UIImage(named: "menu_black")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        imageView.image = menuImage
        self.addSubview(imageView)
        self.loadMenu()
    }
    
    @objc private func handleCoverTap(_ gesture: UITapGestureRecognizer) {
        closeMenu()
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
        setupDisplay()
        let gestureIsDraggingFromLeftToRight = (gesture.velocity(in: superview).x > 0)
        switch gesture.state {
        case .began:
            print("began")
        case .changed:
            if let _ = gesture.view {
                //create method to set the display width
                let newWidth = (self.menuView.frame.width) + gesture.translation(in: superview).x
                self.menuView.frame = CGRect(x: 0, y: 0, width: newWidth, height: ((self.superview?.frame.height)!))
                self.coverView.frame = CGRect(x: newWidth, y: 0, width: (superview?.frame.width)! - newWidth, height: ((self.superview?.frame.height)!))
                self.shadowView.frame = CGRect(x: newWidth - shadowWidth, y: 0, width: shadowWidth, height: ((self.superview?.frame.height)!))
                
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

extension UIView {
    func dropShadow() {
        //self.layer.shadowPath = UIBezierPath(rect: self.layer.bounds).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 3.0, height: 0.0)
        self.layer.shadowRadius = 3.0
        //self.layer.cornerRadius = 5.0
    }
}
