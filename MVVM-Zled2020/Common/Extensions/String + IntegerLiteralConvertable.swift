//
//  Character + IntegerLiteralConvertable.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/21/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation

extension String {
    
    public static func convert(from ascii: [Int]) -> String {
        var convertedStr = ""
        ascii.forEach {
            convertedStr.append(Character(UnicodeScalar($0)!))
        }
        
        return convertedStr
    }
}
