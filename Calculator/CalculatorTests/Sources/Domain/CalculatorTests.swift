//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Omek on 02/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import XCTest

@testable import Calculator

class CalculatorTests: XCTestCase {
    
    // MARK: - Properties
    
    var calculator: Calculator!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    // MARK: - Test utils
    
    private func assert(result: Double, input: Double, operation: OperationType?, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(calculator.result.value, result, file: file, line: line)
        XCTAssertEqual(calculator.input.value, input, file: file, line: line)
        XCTAssertEqual(calculator.operation, operation, file: file, line: line)
    }
    
    private func append(digits: Digit...) {
        for digit in digits {
            calculator.append(digit: digit)
        }
    }
    
    // MARK: - Tests
    
    func testInitialState() {
        assert(result: 0.0, input: 0.0, operation: nil)
    }
    
    func testInput() {
        calculator.append(digit: .two)
        calculator.append(digit: .three)
        XCTAssertEqual(calculator.input.value, 23.0)
    }
    
    func testEqualNoCalculation() {
        calculator.append(digit: .one)
        calculator.append(digit: .seven)
        calculator.equal()
        assert(result: 0.0, input: 17.0, operation: nil)
    }
    
    func testBasicAdd() {
        calculator.append(digit: .two)
        calculator.append(operation: .add)
        calculator.append(digit: .three)
        calculator.equal()
        assert(result: 5.0, input: 0.0, operation: .add)
    }
    
    func testBasicSubtract() {
        calculator.append(digit: .five)
        calculator.append(operation: .subtract)
        calculator.append(digit: .two)
        calculator.equal()
        assert(result: 3.0, input: 0.0, operation: .subtract)
    }
    
    func testBasicMultiply() {
        calculator.append(digit: .four)
        calculator.append(operation: .multiply)
        calculator.append(digit: .six)
        calculator.equal()
        assert(result: 24.0, input: 0.0, operation: .multiply)
    }
    
    func testBasicDivide() {
        calculator.append(digit: .eight)
        calculator.append(operation: .divide)
        calculator.append(digit: .four)
        calculator.equal()
        assert(result: 2.0, input: 0.0, operation: .divide)
    }
    
    func testMultipleAdds() {
        append(digits: .one, .three)
        calculator.append(operation: .add)
        append(digits: .two, .four)
        calculator.append(operation: .add)
        
        assert(result: 37.0, input: 0.0, operation: .add)
        
        append(digits: .five, .six)
        calculator.equal()
        
        assert(result: 93.0, input: 0.0, operation: .add)
    }
    
    func testComplexSequence() {
        append(digits: .nine, .zero, .two)
        calculator.append(operation: .subtract)
        append(digits: .six, .two)
        calculator.append(operation: .divide)
        
        assert(result: 840.0, input: 0.0, operation: .divide)
        
        append(digits: .two, .five)
        calculator.append(operation: .multiply)
        
        assert(result: 33.6, input: 0.0, operation: .multiply)
        
        append(digits: .three, .seven)
        calculator.append(operation: .multiply)
        
        assert(result: 1243.2, input: 0.0, operation: .multiply)
    }
    
    func testAddDecimal() {
        append(digits: .two, .three, .separator, .one, .five)
        calculator.append(operation: .add)
        append(digits: .nine, .separator, .eight, .zero, .two)
        calculator.equal()
        
        assert(result: 32.952, input: 0.0, operation: .add)
    }
    
    func testEqualRepliesCalculation() {
        append(digits: .one, .separator, .five)
        calculator.append(operation: .add)
        append(digits: .one, .separator, .five)
        calculator.append(operation: .add)
        
        assert(result: 3.0, input: 0.0, operation: .add)
        
        // FIXME: Not passing!
        calculator.equal()
        assert(result: 4.5, input: 0.0, operation: .add)
        
        calculator.equal()
        assert(result: 6.0, input: 0.0, operation: .add)
    }
    
    func testSubstractToNegative() {
        append(digits: .nine, .separator, .nine)
        calculator.append(operation: .subtract)
        append(digits: .two, .one, .separator, .six, .one)
        calculator.equal()
        
        assert(result: -11.71, input: 0.0, operation: .subtract)
    }
    
    func testClearEntry() {
        append(digits: .four, .separator, .nine)
        calculator.clearEntry()
        
        assert(result: 0.0, input: 0.0, operation: nil)
    }
    
    func testClearEntryWithResult() {
        append(digits: .four, .separator, .nine)
        calculator.append(operation: .multiply)
        append(digits: .two, .three, .seven)
        calculator.clearEntry()
        
        assert(result: 4.9, input: 0.0, operation: .multiply)
    }
    
    func testClearAll() {
        append(digits: .one, .two, .three, .separator, .nine)
        calculator.append(operation: .divide)
        append(digits: .two)
        calculator.equal()
        calculator.allClear()
        
        assert(result: 0.0, input: 0.0, operation: nil)
    }
    
    func testLeadingZeros() {
        append(digits: .zero, .zero, .two, .seven)
        calculator.append(operation: .add)
        append(digits: .zero, .seven, .one)
        
        assert(result: 27.0, input: 71.0, operation: .add)
    }
    
    func testTrailingZeros() {
        append(digits: .two, .zero, .zero, .separator, .zero, .zero)
        calculator.append(operation: .multiply)
        append(digits: .one, .zero, .two, .separator, .seven, .zero, .zero, .zero, .seven, .zero)
        
        assert(result: 200.0, input: 102.70007, operation: .multiply)
    }
}
