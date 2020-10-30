//
//  StackView + Background.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/27/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    func addBackground(image: UIImage) {
        let imageView = UIImageView(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(imageView, at: 0)
    }
}
