//
//  CalculatorViewModel.swift
//  CalculatorApp
//
//  Created by Omek on 03/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Calculator

class CalculatorViewModel {
    
    // MARK: - Properties
    
    private var calculator: Calculator = Calculator()
    
    // MARK: - Lifecycle
    
    init() {
        updateResult()
    }
    
    // MARK: - Input
    
    enum InputType: Hashable {
        case digit(Digit)
        case operation(OperationType)
        case equal
        case allClear
    }
    
    func append(_ inputType: InputType) {
        switch inputType {
        case .digit(let digit):
            calculator.append(digit: digit)
        case .operation(let operationType):
            calculator.append(operation: operationType)
        case .equal:
            calculator.equal()
        case .allClear:
            calculator.allClear()
        }
        updateResult()
    }
    
    // MARK: - Output
    
    var result: String = "" {
        didSet {
            onResultChanged?(result)
        }
    }
    var onResultChanged: ((String) -> Void)?
    
    // MARK: - Output updates
    
    private func updateResult() {
        if calculator.input.isValidNumber {
            result = "\(calculator.input.value)"
        } else {
            result = "\(calculator.result.value)"
        }
    }
}
