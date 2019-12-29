//
//  MenuDisplay.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 12/28/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//
import Foundation
import UIKit

class MenuBuilder: NSObject {
    
    private let HEADER_HEIGHT = 75
    private let CELL_HEIGHT = 44
    private let HEADER_VIEW = "DrawerHeaderView"
    private let CELL_REUSE_ID = "menuCell"
    private var menuData: MenuData?
    
    func setMenuData(_ data: MenuData?) {
        self.menuData = data
        
    }
    
    func setup(_ menuView: UITableView) {
        menuView.dataSource = self
        menuView.delegate = self
        menuView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_REUSE_ID)
        menuView.bounces = false
    }
}

extension MenuBuilder: HeaderViewDelegate {
    func didPressBack() {
        //deliver callback that back navigation was pressed
    }
    
    func didPressEdit(shouldEdit: Bool) {
        //set editing on table if permitted - deliver callback
    }
}


extension MenuBuilder: UITableViewDataSource {
    
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

extension MenuBuilder: UITableViewDelegate {
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

