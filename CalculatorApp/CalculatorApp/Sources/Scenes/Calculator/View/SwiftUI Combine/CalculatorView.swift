//
//  CalculatorView.swift
//  CalculatorAppSwiftUI
//
//  Created by Tomasz Załoga on 10/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import SwiftUI
import Combine

struct CalculatorView: View {
    
    // MARK: - Configuration
    
    private let rowSpacing: CGFloat = 8.0
    private let columnSpacing: CGFloat = 8.0
    private let padding: CGFloat = 20.0
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel = CalculatorViewModelCombine()
    private let inputLayout = CalculatorInputLayout()
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color(ThemeStore.current.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            CalculatorContentView(result: $viewModel.result, buttonAction: { inputType in
                self.viewModel.append(inputType)
            })
            .padding(padding)
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalculatorView()
            
            CalculatorView()
                .previewDevice("iPhone SE")
        }
    }
}
