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
    
    enum ViewCorners: CaseIterable {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    func roundCorners(radius: CGFloat, corners: CACornerMask = [.layerMinXMinYCorner,.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}

extension String {
    
    static func getTimeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}
