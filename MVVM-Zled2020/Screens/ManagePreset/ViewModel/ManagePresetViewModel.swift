//
//  ManagePresetViewModel.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/22/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

final class ManagePresetViewModel {
    
    var sequenceItems: [SequenceItemViewModel]
    
    init() {
        sequenceItems = LocalService.shared.getAllSequences().map { SequenceItemViewModel($0)
        }
    }
}

extension ManagePresetViewModel: ManagePresetHeaderPresentable {
    var label: String { Constant.Strings.playback }
    var icon: UIImage { (UIImage(named: "icon_db")!.scalePreservingAspectRatio(target: CGSize(width: 40, height: 40))) }
}

protocol ManagePresetHeaderPresentable {
    var label: String { get }
    var icon: UIImage { get }
}
