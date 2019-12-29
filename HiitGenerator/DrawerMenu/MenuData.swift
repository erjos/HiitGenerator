//
//  MenuData.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 12/28/19.
//  Copyright © 2019 Ethan Joseph. All rights reserved.
//

import Foundation

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
    
    //document this init
    init(_ items: [String], title: String) {
        self.title = title
        self.items = items
    }
}
