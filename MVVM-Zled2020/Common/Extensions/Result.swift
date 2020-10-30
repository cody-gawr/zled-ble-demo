//
//  Result.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/6/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation

enum Result<T, E> {
    case success(T)
    case error(E)
}
