//
//  CalculatorViewController.swift
//  CalculatorApp
//
//  Created by Omek on 03/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - Configuration
    
    private let padding: CGFloat = 20.0
    
    // MARK: - Properties
    
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var buttons: [CalculatorButton]!
    
    private let viewModel: CalculatorViewModel = CalculatorViewModel()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: String(describing: Self.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupDesign()
        setupViewModel()
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
    
    private func setupViewModel() {
        viewModel.onResultChanged = { [weak self] result in
            self?.updateResult(result)
        }
        updateResult(viewModel.result)
    }
    
    // MARK: - IBAction
    
    @IBAction private func onButtonTapped(_ button: UIButton) {
        guard let input = CalculatorInputTypeMapper.map(tag: button.tag) else { return }
        viewModel.append(input)
    }
    
    // MARK: - View updated
    
    private func updateResult(_ result: String) {
        resultLabel.text = result
    }
}
