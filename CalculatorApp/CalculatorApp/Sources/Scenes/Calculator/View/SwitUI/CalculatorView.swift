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
    
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ZStack {
                Image("Logo")
                    .aspectRatio(6, contentMode: .fit)
                    .frame(width: 200.0, height: nil, alignment: .center)
            }
            
            Text("Result")
                .frame(minWidth: 0.0, maxWidth: .infinity, alignment: .trailing)
            
            ForEach(rows, id: \.self) { row in
                HStack {
                    ForEach(row, id: \CalculatorViewModel.InputType.name) {
                        CalculatorButton2(type: $0)
                            .frame(minWidth: 0.0, maxWidth: .infinity,
                                   minHeight: 0.0, maxHeight: .infinity)
                    }
                }
            }
        }
        .padding()
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}

struct CalculatorButton2: View {
    var type: CalculatorViewModel.InputType
    
    var body: some View {
        Button(action: {
            
        }) {
            Text(type.name)
        }
    }
}
