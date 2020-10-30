//
//  DeviceListViewModel.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/5/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation
import UIKit
import RxBluetoothKit
import RxSwift

final class DeviceListViewModel: DeviceListViewModelType {
    
    typealias OnErrorBlock = (_ error: Error) -> Void
    
    typealias RefreshBlock = (_ characteristic: Characteristic) -> Void
    
    let bluetoothService: RxBluetoothKitService
    
    var scanningOutput: Observable<Result<ScannedPeripheral, Error>> {
        return bluetoothService.scanningOutput
    }
    
    var isScanning: Bool = false
    
    var isConnected: Bool = false
    
    private let disposeBag = DisposeBag()
    
    private var onErrorBlock: OnErrorBlock = { _ in
    }
    
    private var refreshBlock: RefreshBlock = { _ in
    }
    
    init(with bluetoothService: RxBluetoothKitService) {
        self.bluetoothService = bluetoothService
    }
    
    func setRefreshBlock(_ block: @escaping RefreshBlock) {
        refreshBlock = block
    }
    
    func setOnErrorBlock(_ block: @escaping OnErrorBlock) {
        onErrorBlock = block
    }
    
    func scanAction() {
        if isScanning {
            bluetoothService.stopScanning()
        } else {
            bluetoothService.startScanning()
        }
        
        isScanning = !isScanning
    }
    
    func connectService(to scannedPeripheral: ScannedPeripheral) {
        bluetoothService.discoverCharacteristic(for: scannedPeripheral.peripheral)
            .subscribe(onNext: { [unowned self] result in
                switch result {
                case .success(let characteristic):
                    self.refreshBlock(characteristic)
                case .error(let error):
                    self.onErrorBlock(error)
                }
            }, onError: { self.onErrorBlock($0) })
        .disposed(by: disposeBag)
    }
    
    func save(connectedPeripheral peripheral: Peripheral) {
        LocalService.shared.save(peripheral: peripheral)
    }
}
