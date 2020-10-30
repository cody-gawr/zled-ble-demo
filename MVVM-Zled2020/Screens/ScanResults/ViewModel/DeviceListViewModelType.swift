//
//  DeviceListViewModelType.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/6/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation
import RxBluetoothKit
import RxSwift

protocol DeviceListViewModelType {
    
    var scanningOutput: Observable<Result<ScannedPeripheral, Error>> { get }
    
    var bluetoothService: RxBluetoothKitService { get }
    
    var isScanning: Bool { get set }
    
    func scanAction()
}
