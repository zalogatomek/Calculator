//
//  Number.swift
//  CalculatorTests
//
//  Created by Omek on 02/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import XCTest

@testable import Calculator

class NumberTests: XCTestCase {
    
    // MARK: - Properties
    
    var number: Number!
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
        number = Number()
    }
    
    // MARK: - Tests
    
    func testEmptyNumber() {
        XCTAssertEqual(number.value, 0.0)
    }
    
    func testSingleDigitNumber() {
        number.append(digit: .six)
        XCTAssertEqual(number.value, 6.0)
    }
    
    func testMultiDigitNumber() {
        number.append(digit: .one)
        number.append(digit: .nine)
        number.append(digit: .five)
        number.append(digit: .three)
        XCTAssertEqual(number.value, 1953.0)
    }
    
    func testSeparatorNumber() {
        number.append(digit: .two)
        number.append(digit: .separator)
        number.append(digit: .three)
        number.append(digit: .eight)
        XCTAssertEqual(number.value, 2.38)
    }
    
    func testNumberWithTrailingSeparator() {
        number.append(digit: .seven)
        number.append(digit: .eight)
        number.append(digit: .separator)
        XCTAssertEqual(number.value, 78.0)
    }
    
    func testNumberWithOpeningSeparator() {
        number.append(digit: .separator)
        number.append(digit: .four)
        number.append(digit: .nine)
        number.append(digit: .five)
        XCTAssertEqual(number.value, 0.495)
    }
    
    func testNumberWithOpeningZero() {
        number.append(digit: .zero)
        number.append(digit: .zero)
        number.append(digit: .two)
        number.append(digit: .seven)
        XCTAssertEqual(number.value, 27.0)
    }
    
    func testNumberWithSeparatorAndTrailingZero() {
        number.append(digit: .one)
        number.append(digit: .four)
        number.append(digit: .separator)
        number.append(digit: .nine)
        number.append(digit: .zero)
        XCTAssertEqual(number.value, 14.9)
    }
    
    func testNumberWithMultipleSeparators() {
        number.append(digit: .nine)
        number.append(digit: .separator)
        number.append(digit: .two)
        number.append(digit: .separator)
        number.append(digit: .zero)
        number.append(digit: .separator)
        number.append(digit: .one)
        XCTAssertEqual(number.value, 9.201)
    }
}
