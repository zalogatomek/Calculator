//
//  CalculatorViewController.swift
//  CalculatorApp
//
//  Created by Omek on 03/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var buttons: [CalculatorButton]!
    
    private let viewModel: CalculatorViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
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
        view.layoutMargins = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        view.backgroundColor = ThemeStore.current.backgroundColor
        resultLabel.textColor = ThemeStore.current.textLight
        buttons.forEach {
            $0.kind = CalculatorButtonKindMapper.map(tag: $0.tag)
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
        guard let input = CalculatorViewModelInputTypeMapper.map(tag: button.tag) else { return }
        viewModel.append(input)
    }
    
    // MARK: - View updated
    
    private func updateResult(_ result: String) {
        resultLabel.text = result
    }
}
