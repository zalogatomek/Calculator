//
//  CalculatorViewModelTagToInputMapper.swift
//  CalculatorApp
//
//  Created by Omek on 03/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Calculator

struct CalculatorInputTypeMapper {
    
    private enum Tag: Int {
        case equal = 10
        case add = 11
        case subtract = 12
        case multiply = 13
        case divide = 14
        case allClear = 15
    }
    
    static func map(tag: Int) -> CalculatorInputType? {
        if let digit = Digit(rawValue: tag) {
            return .digit(digit)
        } else if let tag = Tag(rawValue: tag) {
            switch tag {
            case .equal: return .equal
            case .add: return .operation(.add)
            case .subtract: return .operation(.subtract)
            case .multiply: return .operation(.multiply)
            case .divide: return .operation(.divide)
            case .allClear: return .allClear
            }
        }
        
        return nil
    }
}
