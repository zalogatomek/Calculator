//
//  UIColor+Hex.swift
//  CalculatorApp
//
//  Created by Omek on 03/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import UIKit

// source: https://stackoverflow.com/a/24263296
extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha
        )
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(red: (hex >> 16) & 0xFF,
                  green: (hex >> 8) & 0xFF,
                  blue: hex & 0xFF,
                  alpha: alpha
        )
    }
    
    var red: CGFloat{ return CIColor(color: self).red }
    var green: CGFloat{ return CIColor(color: self).green }
    var blue: CGFloat{ return CIColor(color: self).blue }
    var alpha: CGFloat{ return CIColor(color: self).alpha }
}
