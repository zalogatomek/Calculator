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
    
    private var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = Int.max
        return numberFormatter
    }()
    
    // MARK: - Lifecycle
    
    init() {
        updateResult()
    }
    
    // MARK: - Input
    
    func append(_ inputType: CalculatorInputType) {
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
        let number: NSNumber
        if calculator.input.isValidNumber {
            number = NSNumber(value: calculator.input.value)
        } else {
            number = NSNumber(value: calculator.result.value)
        }
        result = numberFormatter.string(from: number) ?? "0"
    }
}
