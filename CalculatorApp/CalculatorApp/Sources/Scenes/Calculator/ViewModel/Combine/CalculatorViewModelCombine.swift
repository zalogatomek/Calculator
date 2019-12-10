//
//  CalculatorViewModelCombine.swift
//  CalculatorApp
//
//  Created by Tomasz Załoga on 10/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Foundation
import Combine

class CalculatorViewModelCombine: ObservableObject {
    
    // MARK: - Properties
    
    private let viewModel: CalculatorViewModel = CalculatorViewModel()
    
    // MARK: - Lifecycle
    
    init() {
        setupViewModel()
    }
    
    private func setupViewModel() {
        result = viewModel.result
        viewModel.onResultChanged = { [weak self] result in
            self?.result = result
        }
    }
    
    // MARK: - Input
    
    func append(_ inputType: CalculatorInputType) {
        viewModel.append(inputType)
    }
    
    // MARK: - Output
    
    @Published var result: String = ""
}
