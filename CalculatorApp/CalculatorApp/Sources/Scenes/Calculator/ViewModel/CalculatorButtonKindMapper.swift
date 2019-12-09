//
//  CalculatorButtonKindMapper.swift
//  CalculatorApp
//
//  Created by Omek on 03/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import UIKit

struct CalculatorButtonKindMapper {
    
    static func map(tag: Int) -> CalculatorButton.Kind {
        let inputType = CalculatorViewModelInputTypeMapper.map(tag: tag)
        return map(inputType: inputType)
    }
    
    static func map(inputType: CalculatorViewModel.InputType?) -> CalculatorButton.Kind {
        switch inputType {
        case .digit: return .digit
        case .operation, .equal: return .operation
        default: return .other
        }
    }
}
