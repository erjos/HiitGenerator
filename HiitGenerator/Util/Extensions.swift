//
//  Extensions.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 4/12/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
