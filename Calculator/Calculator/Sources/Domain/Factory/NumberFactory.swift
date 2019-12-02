//
//  NumberFactory.swift
//  Calculator
//
//  Created by Omek on 02/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Foundation

struct NumberFactory {
    static func create(value: Double) -> Number {
        var number: Number = Number(isNegative: value < 0.0)
        let stringValue = "\(abs(value))"
        
        stringValue.forEach { (character) in
            let intValue = character.toInt() ?? Digit.separator.rawValue
            number.append(digit: Digit(rawValue: intValue) ?? .separator)
        }
        
        return number
    }
}
