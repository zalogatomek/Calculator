//
//  CalculatorViewModelInputType+Name.swift
//  CalculatorApp SwiftUI
//
//  Created by Tomasz Załoga on 09/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Foundation

extension CalculatorViewModel.InputType {
    
    var name: String {
        switch self {
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
