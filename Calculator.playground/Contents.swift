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
    
    private var isNegative: Bool
    private var digits: [Digit]
    
    
    // MARK: - Lifecycle
    
    init(isNegative: Bool = false, digits: [Digit] = []) {
        self.isNegative = isNegative
        self.digits = digits
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

// MARK: - Double + Round

extension Double {
    func rounded(toPlaces decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlaces))
        return (self * divisor).rounded() / divisor
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
        } else if input.isValidNumber {
            result = input
        }
        clearEntry()
        self.operation = operation
    }
    
    mutating func equal() {
        guard let operation = operation else { return }
        result = calculate(first: result, operation: operation, second: input)
        clearEntry()
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
    
    private var maxDecimalPlaces: Int = 8

    private func calculate(first: Number, operation: Operation, second: Number) -> Number {
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

struct NumberFactory {
    static func create(value: Double) -> Number {
        var number: Number = Number(isNegative: value < 0.0)
        let stringValue = "\(abs(value))"
        
        stringValue.forEach { (character) in
            let intValue = character.toInt() ?? Digit.separator.rawValue
            number.append(digit: Digit(rawValue: intValue) ?? .separator)
        }
        
        return number
    }
}

// MARK: - String + Int

extension String {
    func toInt() -> Int? {
        return Int(self)
    }
}

extension String.Element {
    func toInt() -> Int? {
        return "\(self)".toInt()
    }
}

// MARK: - Calculator unit tests

class CalculatorTests: XCTestCase {
    
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }
    
    private func assert(result: Double, input: Double, operation: Operation?, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(calculator.result.value, result, file: file, line: line)
        XCTAssertEqual(calculator.input.value, input, file: file, line: line)
        XCTAssertEqual(calculator.operation, operation, file: file, line: line)
    }
    
    private func append(digits: Digit...) {
        for digit in digits {
            calculator.append(digit: digit)
        }
    }
    
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

CalculatorTests.defaultTestSuite.run()
