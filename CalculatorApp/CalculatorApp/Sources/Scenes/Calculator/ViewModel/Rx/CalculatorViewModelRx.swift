//
//  CalculatorViewModelRx.swift
//  CalculatorApp
//
//  Created by Tomasz Załoga on 10/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CalculatorViewModelRx {
    
    // MARK: - Properties
    
    private let viewModel: CalculatorViewModel = CalculatorViewModel()
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init() {
        setupViewModel()
    }
    
    private func setupViewModel() {
        result.accept(viewModel.result)
        viewModel.onResultChanged = { result in
            self.result.accept(result)
        }
        
        input.subscribe(onNext: { (inputType) in
            self.viewModel.append(inputType)
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: - Input
    
    var input: PublishSubject<CalculatorInputType> = PublishSubject()
    
    // MARK: - Output
    
    var result: BehaviorRelay<String> = BehaviorRelay(value: "")
}
