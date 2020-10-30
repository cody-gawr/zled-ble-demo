//
//  DeviceListViewModelItem.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/6/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import RxBluetoothKit
import UIKit

final class DeviceListViewModelItem: SectionModelItem {
    
    typealias ModelDataType = ScannedPeripheral
    
    var rowData: [ModelDataType] {
        return peripheralRowItems
    }
    
    var itemsCount: Int {
        return peripheralRowItems.count
    }
    
    var cellClass: DeviceListTableViewCell.Type {
        return DeviceListTableViewCell.self
    }
    
    var peripheralRowItems: [ModelDataType]
    
    init(peripheralRowItems: [ModelDataType] = []) {
        self.peripheralRowItems = peripheralRowItems
    }
    
    func append(_ item: ModelDataType) {
        let identicalPeripheral = peripheralRowItems.filter {
            $0.peripheral == item.peripheral
        }
        
        guard identicalPeripheral.isEmpty else {
            return
        }
        if Common.APP_DEBUG {
            peripheralRowItems.append(item)
        } else {
            if item.peripheral.name?.lowercased().contains(Constant.Strings.constraintName) ?? false {
                peripheralRowItems.append(item)
            }
        }
    }
    
    func remove(_ row: Int) {
        
    }
}
