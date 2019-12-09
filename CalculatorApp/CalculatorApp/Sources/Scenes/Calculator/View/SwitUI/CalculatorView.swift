//
//  CalculatorView.swift
//  CalculatorAppSwiftUI
//
//  Created by Tomasz Załoga on 09/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import SwiftUI

struct CalculatorView: View {
    
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
    
    private let rowSpacing: CGFloat = 8.0
    private let columnSpacing: CGFloat = 8.0
    
    var body: some View {
        ZStack {
            Color(ThemeStore.current.backgroundColor)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: rowSpacing) {
                ZStack {
                    Image("Logo")
                        .aspectRatio(6, contentMode: .fit)
                        .frame(width: 200.0, height: nil, alignment: .center)
                }
                
                Text("Result")
                    .font(.title)
                    .foregroundColor(Color(ThemeStore.current.textLight))
                    .frame(minWidth: 0.0, maxWidth: .infinity,
                           minHeight: 0.0, maxHeight: .infinity,
                           alignment: .trailing)
                
                ForEach(rows, id: \.self) { row in
                    GeometryReader { geometry in
                        HStack(alignment: .center, spacing: self.columnSpacing) {
                            ForEach(row, id: \CalculatorViewModel.InputType.name) {
                                CalculatorButtonWrapper(inputType: $0)
                                    .frame(width: self.widthForButton(inRow: row, withType: $0, geometry: geometry))
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
    
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

struct CalculatorButtonWrapper: UIViewRepresentable {
    
    // MARK: - Properties
    
    var inputType: CalculatorViewModel.InputType
    
    // MARK: - UIViewRepresentable
    
    func makeUIView(context: Context) -> CalculatorButton {
        return CalculatorButton()
    }

    func updateUIView(_ uiView: CalculatorButton, context: Context) {
        uiView.kind = CalculatorButtonKindMapper.map(inputType: inputType)
        uiView.setTitle(inputType.name, for: .normal)
    }
}
