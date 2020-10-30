//
//  Int + Hex.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/13/20.
//  Copyright © 2020 Ace. All rights reserved.
//

public extension Int {
    var hexString: String {
        return String(format: "%01X", self)
    }
    
    var binaryValues: [Int] {
        let binaryString: [String] = make4DigitFormat(binaryString: String(self, radix: 2)).map(String.init)
        return binaryString.map { Int($0) ?? 0 }
    }
    
    private func make4DigitFormat(binaryString: String) -> String {
        let countOfZero =  binaryString.count % 4 == 0 ? 0 : 4 - binaryString.count % 4
        var result: String = ""
        for _ in 0..<countOfZero {
            result += "0"
        }
        result += binaryString
        
        return result
    }
}
