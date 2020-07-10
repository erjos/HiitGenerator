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
    
    var stackView = UIStackView()
    
    private var currentCount: Int = 0
    
    private func fillView(for index: Int) {
        guard let circle = self.stackView.arrangedSubviews[index] as? CircleView else { return }
        circle.imageView.image = #imageLiteral(resourceName: "circle_fill")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.stackView.axis = .horizontal
        self.stackView.alignment = .center
        self.stackView.spacing = 8.0
        self.stackView.distribution = .fillEqually
        self.addSubview(self.stackView)
    }
    
    override func layoutSubviews() {
        self.stackView.frame = self.bounds
    }
    
    func incrementCircuit() {
        fillView(for: self.currentCount)
        self.currentCount += 1
        self.setNeedsLayout()
    }
    
    private func reset() {
        self.currentCount = 0
        guard let images = self.stackView.arrangedSubviews as? [CircleView] else { return }
        images.forEach { (circleView) in
            circleView.imageView.image = #imageLiteral(resourceName: "circle_empty")
        }
    }
    
    func configure(for type: CircuitType) {
        for i in 0..<type.rawValue {
            // this causes a bug where we add the circuits multiple times
            self.stackView.addArrangedSubview(CircleView())
        }
    }
}
