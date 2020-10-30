//
//  UIView + Image.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/8/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

extension UIView {
    
    var asImage: UIImage? {
        
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            // If Swift version is lower than 4.2,
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
            defer { UIGraphicsEndImageContext() }
            guard let currentContext = UIGraphicsGetCurrentContext() else {
                return nil
            }
            self.layer.render(in: currentContext)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    }
}
