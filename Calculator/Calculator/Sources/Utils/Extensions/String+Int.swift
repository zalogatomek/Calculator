//
//  String+Int.swift
//  Calculator
//
//  Created by Omek on 02/12/2019.
//  Copyright © 2019 Tomasz Załoga. All rights reserved.
//

import Foundation

extension String {
    func toInt() -> Int? {
        return Int(self)
    }
}

extension String.Element {
    func toInt() -> Int? {
        return "\(self)".toInt()
    }
}
