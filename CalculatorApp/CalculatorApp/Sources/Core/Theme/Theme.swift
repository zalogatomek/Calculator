//
//  Theme.swift
//  CalculatorApp
//
//  Created by Omek on 03/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import UIKit

protocol Theme {
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var tertiaryColor: UIColor { get }
    var backgroundColor: UIColor { get }
    
    var textPrimary: UIColor { get }
    var textSecondary: UIColor { get }
    var textLight: UIColor { get }
}

struct ThemeStore {
    static var current: Theme = SubduedProfessionalTheme()
}

// source: https://www.canva.com/learn/100-color-combinations/

struct SubduedProfessionalTheme: Theme {
    var primaryColor: UIColor { return UIColor(hex: 0x336B87) }
    var secondaryColor: UIColor { return UIColor(hex: 0x2A3132) }
    var tertiaryColor: UIColor { return UIColor(hex: 0x763626) }
    var backgroundColor: UIColor { return UIColor(hex: 0x90AFC5) }
    
    var textPrimary: UIColor { return .black }
    var textSecondary: UIColor { return .lightGray }
    var textLight: UIColor { return .white }
}

struct NeutralVersatileTheme: Theme {
    var primaryColor: UIColor { return UIColor(hex: 0xCDCDC0) }
    var secondaryColor: UIColor { return UIColor(hex: 0xDDBC95) }
    var tertiaryColor: UIColor { return UIColor(hex: 0xB38867) }
    var backgroundColor: UIColor { return UIColor(hex: 0x626D71) }
    
    var textPrimary: UIColor { return .black }
    var textSecondary: UIColor { return .lightGray }
    var textLight: UIColor { return .white }
}

struct SummerFiestaTheme: Theme {
    var primaryColor: UIColor { return UIColor(hex: 0x7AA802) }
    var secondaryColor: UIColor { return UIColor(hex: 0xF78B2D) }
    var tertiaryColor: UIColor { return UIColor(hex: 0xE4B600) }
    var backgroundColor: UIColor { return UIColor(hex: 0xC7DB00) }
    
    var textPrimary: UIColor { return .black }
    var textSecondary: UIColor { return .lightGray }
    var textLight: UIColor { return .white }
}

struct GrecianHolidayTheme: Theme {
    var primaryColor: UIColor { return UIColor(hex: 0x2988BC) }
    var secondaryColor: UIColor { return UIColor(hex: 0x2F496E) }
    var tertiaryColor: UIColor { return UIColor(hex: 0xED8C72) }
    var backgroundColor: UIColor { return UIColor(hex: 0xEAE2D6) }
    
    var textPrimary: UIColor { return .black }
    var textSecondary: UIColor { return .lightGray }
    var textLight: UIColor { return .white }
}
