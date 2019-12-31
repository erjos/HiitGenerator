//
//  DrawerHeaderView.swift
//  MyTrips
//
//  Created by Ethan Joseph on 1/27/19.
//  Copyright © 2019 Joseph, Ethan. All rights reserved.
//

import UIKit

class DrawerHeaderView: UIView {

    @IBOutlet weak var editDoneButton: UIButton!
    @IBOutlet weak var headerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    weak var delegate: HeaderViewDelegate?
    
    private let DEFAULT_MENU_LABEL = "Menu"
    
    private let EDIT_LABEL = "Edit"
    private let DONE_LABEL = "Done"
    
    @IBAction func backButtonPressed(_ sender: Any) {
        delegate?.didPressBack()
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        let isEdit = self.editDoneButton.currentTitle == EDIT_LABEL
        let title = isEdit ? DONE_LABEL : EDIT_LABEL
        self.editDoneButton.setTitle(title, for: .normal)
        
        self.delegate?.didPressEdit(shouldEdit: isEdit)
    }
    
    func setupHeaderView(_ data: MenuData, _ section: Int) {
        let currentSection = data.sections[section]
        headerLabel.text = currentSection.title
        hideBackButton(shouldHide: !data.backButtonVisible)
        if section == 0 {
            hideEditButton(shouldHide: !data.shouldEdit)
        }
    }
    
    private func hideBackButton(shouldHide: Bool) {
        self.backButton.isHidden = shouldHide
        self.headerLeadingConstraint.constant = shouldHide ? 15 : 39
    }
    
    private func hideEditButton(shouldHide: Bool) {
        self.editDoneButton.isHidden = shouldHide
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hideEditButton(shouldHide: true)
        hideBackButton(shouldHide: true)
    }
    
}

protocol HeaderViewDelegate: class {
    func didPressBack()
    func didPressEdit(shouldEdit: Bool)
}
