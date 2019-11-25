import Foundation
import XCTest

// MARK: - Number

enum Digit: Int {
    case separator = -1
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
}

struct Number {
    
    // MARK: - Properties
    
    private var digits: [Digit] = []
    
    // MARK: - Lifecycle
    
    init() {
    }
    
    // MARK: - Number modification
    
    mutating func append(digit: Digit) {
        if digit == .zero && digits.count == 0 {
            return
        }
        if digit == .separator && digits.contains(.separator) {
            return
        }
        digits.append(digit)
    }
    
    // MARK: - Number info
    
    var isValidNumber: Bool {
        return digits.count > 0
    }
    
    var value: Double {
        var value = 0.0
        
        for index in (0..<digits.count) {
            guard let exponent = self.exponent(at: index) else { continue }
            let digit = digits[index]
            value += Double(digit.rawValue) * pow(10.0, Double(exponent))
        }
        
        return valueRounded(value, toPlaces: decimalPlaces)
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
    
    private var decimalPlaces: Int {
        let separatorIndex = digits.firstIndex(of: .separator) ?? digits.count
        return max(0, digits.count - separatorIndex - 1)
    }
    
    private func valueRounded(_ value: Double, toPlaces decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlaces))
        return Double(round(divisor * value) / divisor)
    }
}

// MARK: - Number Unit tests

class NumberTests: XCTestCase {
    
    var number: Number!
    
    override func setUp() {
        super.setUp()
        number = Number()
    }
    
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

NumberTests.defaultTestSuite.run()

enum Operation {
    case add, subtract, multiply, divide
}

struct Calculator {
    
    // MARK: - Properties

    private(set) var result: Number = Number()
    private(set) var input: Number = Number()
    private(set) var operation: Operation?
    
    // MARK: - Lifecycle

    init() {
        
    }
    
    // MARK: - Calculator inputs

    mutating func append(digit: Digit) {
        input.append(digit: digit)
    }

    mutating func append(operation: Operation) {
        if result.isValidNumber, input.isValidNumber, let existingOperation = self.operation {
            result = calculate(first: result, operation: existingOperation, second: input)
        }
        clearEntry()
        self.operation = operation
    }
    
    mutating func equal() {
        guard let operation = operation else { return }
        result = calculate(first: result, operation: operation, second: input)
    }
    
    mutating func allClear() {
        result = Number()
        operation = nil
        clearEntry()
    }
    
    mutating func clearEntry() {
        input = Number()
    }
    
    // MARK: - Logic

    private func calculate(first: Number, operation: Operation, second: Number) -> Number {
        switch operation {
        case .add:
            return Number()
        case .subtract:
            return Number()
        case .multiply:
            return Number()
        case .divide:
            return Number()
        }
    }
}
