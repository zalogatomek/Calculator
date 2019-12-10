//
//  CalculatorViewControllerRx.swift
//  CalculatorApp
//
//  Created by Tomasz Załoga on 10/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CalculatorViewControllerRx: UIViewController {
    
    // MARK: - Configuration
    
    private let padding: CGFloat = 20.0
    
    // MARK: - Properties
    
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var buttons: [CalculatorButton]!
    
    private let viewModel: CalculatorViewModelRx
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(viewModel: CalculatorViewModelRx) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupDesign()
        setupBinding()
    }
    
    private func setupDesign() {
        view.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        view.backgroundColor = ThemeStore.current.backgroundColor
        resultLabel.textColor = ThemeStore.current.textLight
        setupButtons()
    }
    
    private func setupButtons() {
        buttons.forEach { button in
            let inputType = CalculatorInputTypeMapper.map(tag: button.tag)
            button.setTitle(inputType?.name, for: .normal)
            button.kind = CalculatorButtonKindMapper.map(inputType: inputType)
        }
    }
    
    private func setupBinding() {
        bindResult()
        bindButtons()
    }
    
    // MARK: - Binding
    
    private func bindResult() {
        viewModel.result.asDriver()
            .drive(resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindButtons() {
        buttons.forEach { button in
            button.rx.controlEvent(.touchUpInside)
                .compactMap{ CalculatorInputTypeMapper.map(tag: button.tag) }
                .bind(to: viewModel.input)
                .disposed(by: disposeBag)
        }
    }
}
