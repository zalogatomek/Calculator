//
//  Number.swift
//  Calculator
//
//  Created by Omek on 02/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Foundation

public struct Number {
    
    // MARK: - Properties
    
    private var isNegative: Bool
    private var digits: [Digit]
    
    
    // MARK: - Lifecycle
    
    public init(isNegative: Bool = false, digits: [Digit] = []) {
        self.isNegative = isNegative
        self.digits = digits
    }
    
    // MARK: - Number modification
    
    public mutating func append(digit: Digit) {
        if digit == .zero && digits.count == 0 {
            return
        }
        if digit == .separator && digits.contains(.separator) {
            return
        }
        digits.append(digit)
    }
    
    // MARK: - Number info
    
    public var isValidNumber: Bool {
        return digits.count > 0
    }
    
    public var value: Double {
        var value = 0.0
        
        for index in (0..<digits.count) {
            guard let exponent = self.exponent(at: index) else { continue }
            let digit = digits[index]
            value += Double(digit.rawValue) * pow(10.0, Double(exponent))
        }
        
        let rounded = value.rounded(toPlaces: decimalPlaces)
        return isNegative ? -rounded : rounded
    }
    
    private func exponent(at index: Int) -> Int? {
        let separatorIndex = digits.firstIndex(of: .separator) ?? digits.count
        if index < separatorIndex {
            return separatorIndex - index - 1
        } else if index == separatorIndex {
            return nil
        } else {
            return separatorIndex - index
        }
    }
    
    var decimalPlaces: Int {
        let separatorIndex = digits.firstIndex(of: .separator) ?? digits.count
        return max(0, digits.count - separatorIndex - 1)
    }
}
