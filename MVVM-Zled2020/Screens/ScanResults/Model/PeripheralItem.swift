//
//  PeripheralItem.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/11/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import RealmSwift
import RxBluetoothKit
import Foundation

class PeripheralItem: Object {
    @objc dynamic var id = 1
    @objc dynamic var uuid: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
