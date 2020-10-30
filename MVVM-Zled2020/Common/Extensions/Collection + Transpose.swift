//
//  Collection + Transpose.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/17/20.
//  Copyright © 2020 Ace. All rights reserved.
//

extension Collection where Self.Iterator.Element: RandomAccessCollection {
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = self.first else { return [] }
        return firstRow.indices.map { index in
            self.map { $0[index] }
        }
    }
}
