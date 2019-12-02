//
//  Calculator.swift
//  Calculator
//
//  Created by Omek on 02/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Foundation

public struct Calculator {
    
    // MARK: - Properties

    private(set) var result: Number = Number()
    private(set) var input: Number = Number()
    private(set) var operation: OperationType?
    
    // MARK: - Lifecycle

    public init() {
        
    }
    
    // MARK: - Calculator inputs

    public mutating func append(digit: Digit) {
        input.append(digit: digit)
    }

    public mutating func append(operation: OperationType) {
        if result.isValidNumber, input.isValidNumber, let existingOperation = self.operation {
            result = calculate(first: result, operation: existingOperation, second: input)
        } else if input.isValidNumber {
            result = input
        }
        clearEntry()
        self.operation = operation
    }
    
    public mutating func equal() {
        guard let operation = operation else { return }
        result = calculate(first: result, operation: operation, second: input)
        clearEntry()
    }
    
    public mutating func allClear() {
        result = Number()
        operation = nil
        clearEntry()
    }
    
    public mutating func clearEntry() {
        input = Number()
    }
    
    // MARK: - Logic
    
    private var maxDecimalPlaces: Int = 8

    private func calculate(first: Number, operation: OperationType, second: Number) -> Number {
        switch operation {
        case .add:
            let decimalPlaces = min(max(first.decimalPlaces, second.decimalPlaces), maxDecimalPlaces)
            let value = (first.value + second.value).rounded(toPlaces: decimalPlaces)
            return NumberFactory.create(value: value)
        case .subtract:
            let decimalPlaces = min(max(first.decimalPlaces, second.decimalPlaces), maxDecimalPlaces)
            let value = (first.value - second.value).rounded(toPlaces: decimalPlaces)
            return NumberFactory.create(value: value)
        case .multiply:
            let decimalPlaces = min(first.decimalPlaces + second.decimalPlaces, maxDecimalPlaces)
            let value = (first.value * second.value).rounded(toPlaces: decimalPlaces)
            return NumberFactory.create(value: value)
        case .divide:
            let decimalPlaces = maxDecimalPlaces
            let value = (first.value / second.value).rounded(toPlaces: decimalPlaces)
            return NumberFactory.create(value: value)
        }
    }
}
