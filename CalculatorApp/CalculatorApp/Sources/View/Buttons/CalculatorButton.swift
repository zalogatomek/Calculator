//
//  CalculatorButton.swift
//  CalculatorApp
//
//  Created by Omek on 03/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import UIKit

class CalculatorButton: UIButton {
    
    // MARK: - Configurstion
    
    struct Configuration {
        static var cornerRadius: CGFloat = 8.0
        static var backgroundDigitColor: UIColor = ThemeStore.current.primaryColor
        static var backgroundOperationColor: UIColor = ThemeStore.current.secondaryColor
        static var backgroundOtherColor: UIColor = ThemeStore.current.tertiaryColor
        static var textColor: UIColor = ThemeStore.current.textLight
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    
    private func commonSetup() {
        layer.cornerRadius = Configuration.cornerRadius
        setTitleColor(Configuration.textColor, for: .normal)
        setTypeDesign()
    }
    
    // MARK: - Kind
    
    enum Kind {
        case digit, operation, other
    }
    
    var kind: Kind = .digit {
        didSet {
            setTypeDesign()
        }
    }
    
    private func setTypeDesign() {
        switch kind {
        case .digit:
            backgroundColor = Configuration.backgroundDigitColor
        case .operation:
            backgroundColor = Configuration.backgroundOperationColor
        case .other:
            backgroundColor = Configuration.backgroundOtherColor
        }
    }
}
