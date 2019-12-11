//
//  CalculatorView.swift
//  CalculatorAppSwiftUI
//
//  Created by Tomasz Załoga on 09/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import SwiftUI

struct CalculatorView: View {
    
    // MARK: - Configuration
    
    private let padding: CGFloat = 20.0
    
    // MARK: - ViewModel
    
    private let viewModel = CalculatorViewModel()
    @State private var result: String = ""
    
    // MARK: - Lifecycle
    
    private func bindViewModel() {
        result = viewModel.result
        viewModel.onResultChanged = { result in
            self.result = result
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color(ThemeStore.current.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            CalculatorContentView(result: $result, buttonAction: { inputType in
                self.viewModel.append(inputType)
            })
            .padding(padding)
        }
        .onAppear {
            self.bindViewModel()
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
