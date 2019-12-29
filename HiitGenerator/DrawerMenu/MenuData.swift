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
    
    /**
      * Inits menu data with multiple sections
     - Parameters:
        - sections: Collection of the different menu sections.
        - shouldEdit: Boolean that indicates if the menu should be editable. Default is false.
        - backButton: Boolean that indicates if the menu should have a back button. Default is false.
    */
    init(_ sections:[MenuSection], _ shouldEdit: Bool = false, _ backButton: Bool = false) {
        self.backButtonVisible = backButton
        self.shouldEdit = shouldEdit
        self.sections = sections
    }
    
    /**
      * Inits menu data with a single section.
     - Parameters:
        - sections: Collection of the different menu sections.
        - shouldEdit: Boolean that indicates if the menu should be editable. Default is false.
        - backButton: Boolean that indicates if the menu should have a back button. Default is false.
    */
    init(_ title: String, _ items: [String], _ shouldEdit: Bool = false, _ backButton: Bool = false) {
        self.sections = [MenuSection(items, title: title)]
        self.shouldEdit = shouldEdit
        self.backButtonVisible = backButton
    }
}

struct MenuSection {
    var title : String
    var items : [String]
    
    /**
      * Inits menu section with title and item list.
     - Parameters:
        - items: Collection of the different menu items for the section.
        - title: The header title displayed for the section.
    */
    init(_ items: [String], title: String) {
        self.title = title
        self.items = items
    }
}
