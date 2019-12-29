//
//  DrawerMenu.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 12/27/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import Foundation
import UIKit

//could eventually make it so that the menu appears from the top bottom left or right

//what do we need to set up the table?
//header name for each section
//items for each section

//is editable
//should navigate back

//so we could have multiple states, but we can just reconfigure the table for that...

class DrawerMenu: UIControl {
    
    weak var gestureDelegate : DrawerGestureDelegate?
    private let CELL_REUSE_ID = "menuCell"
    let HEADER_HEIGHT = 75
    let CELL_HEIGHT = 44
    let HEADER_VIEW = "DrawerHeaderView"
    
    lazy var menuDisplay: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    private var isDisplayAdded = false
    
    func addDisplayToView() {
        guard !isDisplayAdded else { return }
        self.superview?.addSubview(menuDisplay)
        isDisplayAdded = true
    }
    func setupDisplay() {
        menuDisplay.delegate = self
        menuDisplay.dataSource = self
        menuDisplay.register(UITableViewCell.self, forCellReuseIdentifier: CELL_REUSE_ID)
        menuDisplay.backgroundColor = .darkGray
    }
    
    func getPanGesture(target: DrawerGestureDelegate) -> UIPanGestureRecognizer {
        self.gestureDelegate = target
        return UIPanGestureRecognizer(target: gestureDelegate, action: #selector(gestureDelegate?.handlePanGesture(_:)))
    }
    
    //might be able to combine these
    func openMenu() {
        addDisplayToView()
        UIView.animate(withDuration: 0.2) {
            self.menuDisplay.frame = CGRect(x: 0, y: 0, width: 300, height: (self.superview?.frame.height)!)
            self.superview?.layoutIfNeeded()
        }
    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.2) {
            self.menuDisplay.frame = CGRect(x: 0, y: 0, width: 0, height: (self.superview?.frame.height)!)
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
        self.setupDisplay()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DrawerMenu.didTap(_:))))
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        openMenu()
    }
    
    //call this function from the handlePanGesture delegate function to allow interaction with the menu from any class
    func handleGesture(_ gesture: UIPanGestureRecognizer) {
        addDisplayToView()
        let gestureIsDraggingFromLeftToRight = (gesture.velocity(in: superview).x > 0)
        switch gesture.state {
        case .began:
            print("began")
        case .changed:
            if let _ = gesture.view {
                //create method to set the display width
                self.menuDisplay.frame = CGRect(x: 0, y: 0, width: (self.menuDisplay.frame.width) + gesture.translation(in: superview).x, height: ((self.superview?.frame.height)!))
                
                //self.menuCoverWidth.constant = UIScreen.main.bounds.width - self.menuWidth.constant
                gesture.setTranslation(CGPoint.zero, in: superview)
            }
            //implements logic to determine if menu should remain open or closed
        case .ended:
            if gestureIsDraggingFromLeftToRight {
                let hasMovedGreaterThanHalfway = (menuDisplay.frame.width) > 150
                if (hasMovedGreaterThanHalfway) {
                    self.openMenu()
                } else {
                    self.closeMenu()
                }
            } else {
                let hasMovedGreaterThanHalfway = (menuDisplay.frame.width) < 150
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
    func numberOfSections(in tableView: UITableView) -> Int {
        //make this dynamic
        return 1
    }
    //handles table setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //make this dynamic
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_ID, for: indexPath)
        
        //configure cell
        cell.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)//.darkGray
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.lineBreakMode = .byClipping
        cell.selectionStyle = .none
        
        cell.textLabel?.text = "test"
        
        return cell
    }
}

extension DrawerMenu: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = Bundle.main.loadNibNamed(HEADER_VIEW, owner: self, options: nil)?.first as? DrawerHeaderView else {
            print("Failed to load and cast view")
            return UIView()
        }
        
        header.delegate = self
        //header.setupHeaderView(tableState: tableState)
        tableView.setEditing(false, animated: false)
        return header
    }
    //handles passing the table selection to the delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //pass relevant data into the delegate method
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(HEADER_HEIGHT)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(HEADER_HEIGHT)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let rect = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: HEADER_HEIGHT)
        let footer = UIView(frame: rect)
        footer.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1)
        return footer
    }
}

struct MenuData {
    var backButtonVisible: Bool
    var shouldEdit: Bool
    var sections: [MenuSection]
}

struct MenuSection {
    var title : String
    var items : [String]
}

@objc protocol DrawerGestureDelegate : class {
    /**
      * Handles the pan gesture from the view controller where the menu exists. ViewControllers that implement this method should call the handleGesture(_ gesture: UIPanGestureRecognizer) function on the DrawerMenu and getPanGesture(target: DrawerGestureDelegate) -> UIPanGestureRecognizer to create and add the pan gesture to their view.
     - Parameters:
        - gesture: the pan gesture recognizer that is generated from the getPanGesture method on the DrawerMenu
    */
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer)
}

protocol DrawerMenuDelegate: class {
    
    /**
      * Sets the data source for the menu
     - Parameters:
        - menuData: the object that represents the data in the menu
    */
    func setDataSource(menuData: MenuData)
}

extension DrawerMenu: HeaderViewDelegate {
    func didPressBack() {
        //changeTableState(state: .Menu)
    }
    
    func didPressEdit(shouldEdit: Bool) {
        //setEditing(shouldEdit, animated: true)
    }
}
