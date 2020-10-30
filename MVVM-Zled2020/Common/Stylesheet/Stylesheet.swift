//
//  Stylesheet.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/5/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

enum Stylesheet {
    
    enum Commons {
        static let lgLabel = Style<UILabel> {
            $0.font = .systemFont(ofSize: Constant.FontSize.large)
            $0.numberOfLines = 0
            $0.textColor = Constant.UIColors.white
            $0.textAlignment = .center
        }
        
        static let appLabel = Style<UILabel> {
            $0.font = .systemFont(ofSize: Constant.FontSize.large)
            $0.numberOfLines = 0
            $0.textColor = Constant.UIColors.red
            $0.textAlignment = .center
        }
        
        static let mdLabel = Style<UILabel> {
            $0.font = .systemFont(ofSize: Constant.FontSize.medium)
            $0.numberOfLines = 0
            $0.textColor = Constant.UIColors.white
            $0.textAlignment = .center
        }
        
        static let smLabel = Style<UILabel> {
            $0.font = .systemFont(ofSize: Constant.FontSize.small)
            $0.numberOfLines = 0
            $0.textColor = Constant.UIColors.white
            $0.textAlignment = .center
        }
        
        static let alertTitleLabel = Style<UILabel> {
            $0.font = .systemFont(ofSize: Constant.FontSize.medium)
            $0.numberOfLines = 0
            $0.textColor = Constant.UIColors.background
            $0.textAlignment = .center
        }
        
        static let scanIcon = Style<UIImageView> {
            $0.frame.size.width = 50
            $0.frame.size.height = 50
            $0.contentMode = .scaleAspectFit
        }
        
        static let scanButton = Style<UIButton> {
            $0.setTitleColor(Constant.UIColors.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: Constant.FontSize.medium)
            $0.setBackgroundColor(Constant.UIColors.blue, for: .normal)
            $0.setBackgroundColor(Constant.UIColors.smartBlue, for: .highlighted)
            $0.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
            $0.layer.cornerRadius = 5
            $0.clipsToBounds = true
        }
    
        static let activityIndicator = Style<UIActivityIndicatorView> {
            $0.color = .white
            $0.style = .large
        }
        
        static let vStackView = Style<UIStackView> {
            $0.distribution = .fillEqually
            $0.alignment = .fill
            $0.axis = .vertical
        }
        
        static let playbackName = Style<UILabel> {
            $0.backgroundColor = Constant.UIColors.tabBackground.withAlphaComponent(0.1)
            $0.textColor = Constant.UIColors.red
            $0.font = .systemFont(ofSize: Constant.FontSize.large)
            $0.textAlignment = .center
        }
        
        static let menuTitleLabel = Style<UILabel> {
            $0.font = .systemFont(ofSize: Constant.FontSize.small)
            $0.textColor = Constant.UIColors.background
            $0.textAlignment = .center
        }
        
        static let frameControlButton = Style<UIButton> {
            $0.frame.size.width = 30
            $0.frame.size.height = 30
        }
    }
}
