//
//  CalculatorInputLayout.swift
//  CalculatorApp
//
//  Created by Tomasz Załoga on 10/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Foundation

struct CalculatorInputLayout {
    
    let rows: [[CalculatorInputType]] = [
        [.allClear, .operation(.divide)],
        [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiply)],
        [.digit(.four), .digit(.five), .digit(.six), .operation(.subtract)],
        [.digit(.one), .digit(.two), .digit(.three), .operation(.add)],
        [.digit(.zero), .digit(.separator), .equal]
    ]
    
    let forceSingleWidthElements: [CalculatorInputType] = [
        .operation(.divide), .digit(.separator), .equal
    ]
}
