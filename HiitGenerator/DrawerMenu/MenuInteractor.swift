//
//  MenuDisplay.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 12/28/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//
import Foundation
import UIKit

class MenuInteractor: NSObject {
    
    private let HEADER_HEIGHT = 75
    private let CELL_HEIGHT = 44
    private let HEADER_VIEW = "DrawerHeaderView"
    private let CELL_REUSE_ID = "menuCell"
    private var menuData: MenuData?
    
    lazy var menuTable: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    func setMenuData(_ menu: DrawerMenu) {
        self.menuData = delegate?.setDataSource(drawerMenu: menu)
    }
    
    weak var delegate: MenuInteractorDelegate?
    
    /**
      * Sets up the data source and delegate for the menu table view to be handled by the interactor rather than the DrawerMenu class. Cannot be used for styling the menu.
     - Parameters:
        - menuView: The table view that represents the menu.
    */
    func setup(_ menuView: UITableView) {
        menuView.dataSource = self
        menuView.delegate = self
        menuView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_REUSE_ID)
        menuView.bounces = false
        menuTable = menuView
    }
}

protocol MenuInteractorDelegate : class {
    /**
      * Sets the data source for the menu, implementation should return MenuDataObject. Can be used to reconfigure menu properites when the data source is changed or updated.
     - Parameters:
        - drawerMenu: The menu object that is requesting a new data source.
    */
    func setDataSource(drawerMenu: DrawerMenu)-> MenuData
    
    /**
      * Called when a row in the menu display table is selected.
     - Parameters:
        - indexPath: The indexPath of the selected item
        - label: The label of the selected item.
    */
    func didSelectItem(indexPath: IndexPath, label: String)
    
    /**
     Called when the user clicks on the back navigation in the menu header.
     */
    func didPressBack()
    
    /// Called when user deletes an item from the table
    /// - Parameters:
    ///   - indexPath: The index path of the item to be removed from the data source.
    ///   - label: The label of the item to be removed.
    func didDeleteItem(indexPath: IndexPath, label: String)
}

extension MenuInteractor: HeaderViewDelegate {
    func didPressBack() {
        delegate?.didPressBack()
    }
    
    func didPressEdit(shouldEdit: Bool) {
        self.menuTable.setEditing(shouldEdit, animated: true)
    }
}


extension MenuInteractor: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuData?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData?.sections[section].items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_ID, for: indexPath)
        
        //CONFIGURE CELL
        cell.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.lineBreakMode = .byClipping
        cell.selectionStyle = .none
        
        //SET TITLE
        if let item = menuData?.sections[indexPath.section].items[indexPath.row] {
            cell.textLabel?.text = item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let item = menuData?.sections[indexPath.section].items[indexPath.row] else { return }
            self.delegate?.didDeleteItem(indexPath: indexPath, label: item)
        }
    }
}

extension MenuInteractor: UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = menuData?.sections[indexPath.section].items[indexPath.row] else { return }
        delegate?.didSelectItem(indexPath: indexPath, label: item)
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

