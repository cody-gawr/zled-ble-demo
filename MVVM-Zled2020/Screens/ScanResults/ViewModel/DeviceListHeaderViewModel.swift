//
//  DeviceListHeaderViewModel.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/6/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation
import UIKit

final class DeviceListHeaderViewModel: HeaderViewPresentable {
    var image: UIImage {
        let image = UIImage(named: "icon_search_device")!
        return image.scalePreservingAspectRatio(target: CGSize(width: 50, height: 50))
    }
    var text: String {
        return Constant.Strings.scanDevice
    }
}

protocol HeaderViewPresentable {
    var image: UIImage { get }
    var text: String { get }
}
