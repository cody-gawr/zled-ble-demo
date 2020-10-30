//
//  String + Hex.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/14/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation

public extension String {
    
    var hexValue: Int {
        return Int(strtoul(self, nil, 16))
    }
}
