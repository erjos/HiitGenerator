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
    
    private var currentCount: Int = 0
    
    private func fillView(for index: Int) {
        guard let circle = self.stackView.arrangedSubviews[index] as? CircleView else { return }
        circle.imageView.image = #imageLiteral(resourceName: "circle_fill")
    }
    
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
    
    func incrementCircuit() {
        fillView(for: self.currentCount)
        self.currentCount += 1
        self.setNeedsLayout()
    }
    
    private func reset() {
        self.currentCount = 0
        let images = self.stackView.arrangedSubviews.map { (view) -> UIImageView in
            return view as! UIImageView
        }
        images.forEach { (imageView) in
            imageView.image = #imageLiteral(resourceName: "circle_empty")
        }
    }
    
    func configure(for type: CircuitType) {
        for i in 0..<type.rawValue {
            let circle = CircleView()
            self.stackView.addArrangedSubview(circle)
        }
    }
}
