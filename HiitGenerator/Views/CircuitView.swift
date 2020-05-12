//
//  CircuitView.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 5/11/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import Foundation
import UIKit

class CircuitView: UIView {
    
    var stackView: UIStackView!
    
    //Should setup a max width here to handle it
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        self.addSubview(self.stackView)
    }
    
    override func layoutSubviews() {
        self.stackView.frame = self.bounds
    }
    
    func configure(for type: CircuitType) {
        for i in 0..<type.rawValue {
            let circle = CircleView()
            self.stackView.addArrangedSubview(circle)
        }
        
        self.setNeedsLayout()
    }
}
