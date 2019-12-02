//
//  Double+Round.swift
//  Calculator
//
//  Created by Omek on 02/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Foundation

extension Double {
    func rounded(toPlaces decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlaces))
        return (self * divisor).rounded() / divisor
    }
}
