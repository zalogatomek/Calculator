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

struct CalculatorContentView: View {
    
    // MARK: - Configuration
    
    private let rowSpacing: CGFloat = 8.0
    private let columnSpacing: CGFloat = 8.0
    private let inputLayout = CalculatorInputLayout()
    
    // MARK: - Properties
    
    @Binding var result: String
    var buttonAction: (CalculatorInputType) -> Void
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .center, spacing: rowSpacing) {
            ZStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: nil)
            }
            .frame(minWidth: 0.0, maxWidth: .infinity,
                   minHeight: 0.0, maxHeight: .infinity)
            
            Text(result)
                .font(.title)
                .foregroundColor(Color(ThemeStore.current.textLight))
                .frame(minWidth: 0.0, maxWidth: .infinity,
                       minHeight: 0.0, maxHeight: .infinity,
                       alignment: .trailing)
            
            ForEach(inputLayout.rows, id: \.self) { row in
                GeometryReader { geometry in
                    HStack(alignment: .center, spacing: self.columnSpacing) {
                        ForEach(row, id: \CalculatorInputType.name) { inputType in
                            CalculatorButtonRepresentable(
                                name: inputType.name,
                                kind: CalculatorButtonKindMapper.map(inputType: inputType),
                                action: {
                                    self.buttonAction(inputType)
                                })
                                .frame(width: self.widthForButton(inRow: row, withType: inputType, geometry: geometry))
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Tools
    
    private func widthForButton(inRow row: [CalculatorInputType],
                                withType inputType: CalculatorInputType,
                                geometry: GeometryProxy) -> CGFloat
    {
        let maxColumns = CGFloat(inputLayout.rows.map{ $0.count }.max() ?? 4)
        let maxSpacing = (maxColumns - 1) * columnSpacing
        let columns = CGFloat(row.count)
        let spacing = (columns - 1) * columnSpacing
        let singleButtonWidth = (geometry.size.width - maxSpacing) / maxColumns
        
        if inputLayout.forceSingleWidthElements.contains(inputType) {
            return singleButtonWidth
        } else {
            return geometry.size.width - spacing - ((columns - 1) * singleButtonWidth)
        }
    }
}
