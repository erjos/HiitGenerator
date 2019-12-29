//
//  DrawerMenu.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 12/27/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import Foundation
import UIKit

//TODO: add enum that controls menu location and style (top,left,bottom,etc.)
class DrawerMenu: UIControl {
    
    private let CELL_REUSE_ID = "menuCell"
    private let HEADER_HEIGHT = 75
    private let CELL_HEIGHT = 44
    private let HEADER_VIEW = "DrawerHeaderView"
    
    weak var gestureDelegate : DrawerGestureDelegate?
    weak var delegate: DrawerMenuDelegate?
    
    private var menuData: MenuData?
    
    lazy var menuDisplay: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    private var isDisplayAdded = false
    
    private func addDisplayToView() {
        guard !isDisplayAdded else { return }
        self.superview?.addSubview(menuDisplay)
        isDisplayAdded = true
    }
    
    //document this function
    func loadMenu() {
        menuData = delegate?.setDataSource(drawerMenu: self)
        menuDisplay.reloadData()
    }
    
    private func setupDisplay() {
        menuDisplay.delegate = self
        menuDisplay.dataSource = self
        menuDisplay.register(UITableViewCell.self, forCellReuseIdentifier: CELL_REUSE_ID)
    }
    
    func getPanGesture() -> UIPanGestureRecognizer {
        return UIPanGestureRecognizer(target: gestureDelegate, action: #selector(gestureDelegate?.handlePanGesture(_:)))
    }
    
    //might be able to combine these
    private func openMenu() {
        addDisplayToView()
        UIView.animate(withDuration: 0.2) {
            self.menuDisplay.frame = CGRect(x: 0, y: 0, width: 300, height: (self.superview?.frame.height)!)
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func closeMenu() {
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
        self.setupDisplay()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DrawerMenu.didTap(_:))))
        
        let menuImage = UIImage(named: "menu_black")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        imageView.image = menuImage
        self.addSubview(imageView)
        self.loadMenu()
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
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
        return menuData?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData?.sections[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_ID, for: indexPath)
        
        //configure cell
        cell.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.lineBreakMode = .byClipping
        cell.selectionStyle = .none
        
        //set cell title
        if let item = menuData?.sections[indexPath.section].items[indexPath.row] {
            cell.textLabel?.text = item
        }
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
        if let data = menuData {
            header.setupHeaderView(data, section)
        }
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
    
    //document these inits
    init(_ sections:[MenuSection], _ shouldEdit: Bool = false, _ backButton: Bool = false) {
        self.backButtonVisible = backButton
        self.shouldEdit = shouldEdit
        self.sections = sections
    }
    
    init(_ title: String, _ items: [String], _ shouldEdit: Bool = false, _ backButton: Bool = false) {
        self.sections = [MenuSection(items, title: title)]
        self.shouldEdit = shouldEdit
        self.backButtonVisible = backButton
    }
}

struct MenuSection {
    var title : String
    var items : [String]
    
    //document init
    init(_ items: [String], title: String) {
        self.title = title
        self.items = items
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

extension DrawerMenu: HeaderViewDelegate {
    func didPressBack() {
        //changeTableState(state: .Menu)
    }
    
    func didPressEdit(shouldEdit: Bool) {
        //setEditing(shouldEdit, animated: true)
    }
}
