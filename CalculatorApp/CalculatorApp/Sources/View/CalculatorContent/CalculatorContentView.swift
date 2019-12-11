//
//  CalculatorContentView.swift
//  CalculatorApp
//
//  Created by Tomasz Załoga on 11/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import SwiftUI

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

struct CalculatorContentView_Previews: PreviewProvider {
    @State static var result: String = "0"
    
    static var previews: some View {
        Group {
            CalculatorContentView(result: $result, buttonAction: { _ in })
                .background(Color(ThemeStore.current.backgroundColor))
                .previewLayout(.fixed(width: 300, height: 500))
        }
    }
}
