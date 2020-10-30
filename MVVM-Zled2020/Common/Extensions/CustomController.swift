//
//  CustomController.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/5/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

protocol CustomController {
    func setNavigationBar()
}

extension CustomController where Self: UIViewController {
    
    func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func enablePop() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func disablePop() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}
