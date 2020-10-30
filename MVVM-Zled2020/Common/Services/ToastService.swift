//
//  ToastService.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/10/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit
import Toast_Swift

final class ToastService {
    
    public var parentView: UIView?
    
    init(on parentView: UIView? = nil) {
        self.parentView = parentView
        ToastManager.shared.isTapToDismissEnabled = true
    }
    
    func showToast(_ text: String, type: ToastType) {
        var style = ToastStyle()
        style.messageFont = UIFont.systemFont(ofSize: Constant.FontSize.medium)
        style.messageAlignment = .center
        switch type {
        case .success:
            style.backgroundColor = Constant.UIColors.green
        case .warning:
            style.backgroundColor = Constant.UIColors.yellow
        case .error:
            style.backgroundColor = Constant.UIColors.red
        }
        parentView?.makeToast(text, duration: 2.0, position: .center, style: style)
    }
}

extension ToastService {
    enum ToastType {
        case success
        case warning
        case error
    }
}
