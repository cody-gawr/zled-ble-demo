//
//  Results + toArray.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/25/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
