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
    
    private let rowSpacing: CGFloat = 8.0
    private let columnSpacing: CGFloat = 8.0
    
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
    
    // MARK: - Calculator buttons
    
    let rows: [[CalculatorViewModel.InputType]] = [
        [.allClear, .operation(.divide)],
        [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.multiply)],
        [.digit(.four), .digit(.five), .digit(.six), .operation(.subtract)],
        [.digit(.one), .digit(.two), .digit(.three), .operation(.add)],
        [.digit(.zero), .digit(.separator), .equal]
    ]
    
    let forceSingleWidthElements: [CalculatorViewModel.InputType] = [
        .operation(.divide), .digit(.separator), .equal
    ]
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color(ThemeStore.current.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: rowSpacing) {
                ZStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(6, contentMode: .fit)
                        .frame(width: 200.0, height: nil)
                }
                
                Text(result)
                    .font(.title)
                    .foregroundColor(Color(ThemeStore.current.textLight))
                    .frame(minWidth: 0.0, maxWidth: .infinity,
                           minHeight: 0.0, maxHeight: .infinity,
                           alignment: .trailing)
                
                ForEach(rows, id: \.self) { row in
                    GeometryReader { geometry in
                        HStack(alignment: .center, spacing: self.columnSpacing) {
                            ForEach(row, id: \CalculatorViewModel.InputType.name) { inputType in
                                CalculatorButtonRepresentable(inputType: inputType, action: {
                                    self.viewModel.append(inputType)
                                })
                                .frame(width: self.widthForButton(inRow: row, withType: inputType, geometry: geometry))
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            self.bindViewModel()
        }
    }
    
    // MARK: - Tools
    
    private func widthForButton(inRow row: [CalculatorViewModel.InputType],
                                withType inputType: CalculatorViewModel.InputType,
                                geometry: GeometryProxy) -> CGFloat
    {
        let maxColumns = CGFloat(rows.map{ $0.count }.max() ?? 4)
        let maxSpacing = (maxColumns - 1) * columnSpacing
        let columns = CGFloat(row.count)
        let spacing = (columns - 1) * columnSpacing
        let singleButtonWidth = (geometry.size.width - maxSpacing) / maxColumns
        
        if forceSingleWidthElements.contains(inputType) {
            return singleButtonWidth
        } else {
            return geometry.size.width - spacing - ((columns - 1) * singleButtonWidth)
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
