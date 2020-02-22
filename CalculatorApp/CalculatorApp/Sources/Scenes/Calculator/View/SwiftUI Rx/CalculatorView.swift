//
//  CalculatorView.swift
//  CalculatorAppSwiftUI
//
//  Created by Tomasz Załoga on 10/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import SwiftUI
import RxSwift
import RxCocoa

struct CalculatorView: View {
    
    // MARK: - Configuration
    
    private let padding: CGFloat = 20.0
    
    // MARK: - Properties
    
    private let viewModel = CalculatorViewModelRx()
    private let inputLayout = CalculatorInputLayout()
    @State private var result: String = ""
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    private func bindViewModel() {
        viewModel.result.subscribe(onNext: { result in
            self.result = result
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color(ThemeStore.current.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            CalculatorContentView(result: $result, buttonAction: { inputType in
                self.viewModel.input.onNext(inputType)
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
