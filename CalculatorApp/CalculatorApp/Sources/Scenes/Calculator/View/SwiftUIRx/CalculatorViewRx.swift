//
//  CalculatorViewRx.swift
//  CalculatorAppSwiftUI
//
//  Created by Tomasz Załoga on 10/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import SwiftUI
import RxSwift
import RxCocoa

struct CalculatorViewRx: View {
    
    // MARK: - Configuration
    
    private let rowSpacing: CGFloat = 8.0
    private let columnSpacing: CGFloat = 8.0
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
                                        self.viewModel.input.onNext(inputType)
                                })
                                .frame(width: self.widthForButton(inRow: row, withType: inputType, geometry: geometry))
                            }
                        }
                    }
                }
            }
            .padding(padding)
        }
        .onAppear {
            self.bindViewModel()
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

struct CalculatorViewRx_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorViewRx()
    }
}
