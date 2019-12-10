//
//  CalculatorButtonWrapper.swift
//  CalculatorApp SwiftUI
//
//  Created by Tomasz Załoga on 10/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import SwiftUI

struct CalculatorButtonRepresentable: UIViewRepresentable {
    
    // MARK: - Properties
    
    var name: String
    var kind: CalculatorButton.Kind
    var action: () -> Void
    
    // MARK: - UIViewRepresentable
    
    func makeUIView(context: Context) -> CalculatorButton {
        let button = CalculatorButton(type: .system)
        button.addTarget(context.coordinator,
                         action: #selector(Coordinator.buttonTapped),
                         for: .touchUpInside)
        
        return button
    }

    func updateUIView(_ uiView: CalculatorButton, context: Context) {
        uiView.setTitle(name, for: .normal)
        uiView.kind = kind
    }
    
    // MARK: - Coordinator
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var calculatorButton: CalculatorButtonRepresentable

        init(_ calculatorButton: CalculatorButtonRepresentable) {
            self.calculatorButton = calculatorButton
        }
        
        @objc func buttonTapped() {
            calculatorButton.action()
        }
    }
}
