//
//  SequenceItemViewModel.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/31/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit

struct SequenceItemViewModel: SequenceItemPresentable {
    
    var item: SequenceItem
    
    var icon = UIImage(named: "icon_playback")!.scalePreservingAspectRatio(target: CGSize(width: 35, height: 35))
    
    var trashIcon = UIImage(named: "icon_trash")!.scalePreservingAspectRatio(target: CGSize(width: 25, height: 25))
    
    var sequenceName: String {
        self.item.sequenceName
    }
    
    var dateTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return formatter.string(from: item.dateTime)
    }
    
    init(_ item: SequenceItem) {
        self.item = item
    }
}

protocol SequenceItemPresentable {
    
    var icon: UIImage { get }
    var sequenceName: String { get }
    var dateTime: String { get }
    var trashIcon: UIImage { get }
}
