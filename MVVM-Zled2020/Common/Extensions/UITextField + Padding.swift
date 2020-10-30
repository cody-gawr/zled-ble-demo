//
//  UITextField + Padding.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/10/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
