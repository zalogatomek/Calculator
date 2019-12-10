//
//  CalculatorInputType.swift
//  CalculatorApp
//
//  Created by Tomasz Załoga on 10/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Foundation
import Calculator

enum CalculatorInputType: Hashable {
    case digit(Digit)
    case operation(OperationType)
    case equal
    case allClear
}

extension CalculatorInputType {
    
    var name: String {
        switch self {
        case .digit(let digit) where digit == .separator:
            return NumberFormatter().decimalSeparator
        case .digit(let digit):
            return "\(digit.rawValue)"
        case .operation(let operationType):
            switch operationType {
            case .add:
                return "+"
            case .subtract:
                return "-"
            case .multiply:
                return "*"
            case .divide:
                return "/"
            }
        case .equal:
            return "="
        case .allClear:
            return "AC"
        }
    }
}
