//
//  UIView + Style.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/5/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

extension UIView {

    public convenience init<V>(style: Style<V>) {
        self.init(frame: .zero)
        apply(style)
    }

    public func apply<V>(_ style: Style<V>) {
        guard let view = self as? V else {
            print("Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
}
