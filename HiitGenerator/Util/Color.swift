//
//  Color.swift
//  HiitGenerator
//
//  Created by Ethan Joseph on 5/5/20.
//  Copyright © 2020 Ethan Joseph. All rights reserved.
//
import Foundation
import UIKit

var viewMode: ViewMode = .light

enum ViewMode {
    case light
    case dark
}

//TODO: consider an enum for this
class Color {
    static var topViewNormal: UIColor {
        return UIColor(red: 213/255, green: 202/255, blue: 247/255, alpha: 1.0)
    }
    
    static var topViewPause: UIColor {
        return UIColor.yellow.withAlphaComponent(0.3)
    }
    
    static var topViewBreak: UIColor {
        return UIColor.red.withAlphaComponent(0.3)
    }
    
    static var filledCell: UIColor {
        return UIColor.blue.withAlphaComponent(0.3)
    }
}
