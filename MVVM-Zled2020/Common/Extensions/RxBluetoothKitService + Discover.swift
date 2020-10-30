//
//  RxBluetoothKitService + Discover.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/11/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation
import CoreBluetooth
import RxSwift
import RxBluetoothKit

extension RxBluetoothKitService {
    
    /// UUID of the service to look for.
    static let serviceUUID = CBUUID(string: "FFE0")
    /// UUID of the characteristic to look for.
    static let characteristicUUID = CBUUID(string: "FFE1")
    
    func filter(for result: Result<[Service], Error>) -> Service? {
        var coreService: Service?
        
        switch result {
        case .success(let items):
            if let firstIndex = items.firstIndex(where: { $0.service.uuid == Self.serviceUUID }) {
                coreService = items[firstIndex]
            }
            if let firstIndex = items.firstIndex(where: { String(describing: $0.service.uuid).count == 4 }) {
                coreService = items[firstIndex]
            }
        default:
            coreService = nil
        }
        
        return coreService
    }
    
    func filter(for result: Result<[Characteristic], Error>) -> Result<Characteristic, Error> {
        var coreCharacteristic: Characteristic?
        
        switch result {
        case .success(let items):
            if let firstIndex = items.firstIndex(where: { $0.uuid == Self.characteristicUUID }) {
                coreCharacteristic = items[firstIndex]
            }
            if let firstIndex = items.firstIndex(where: { String(describing: $0.uuid).count == 4 }) {
                coreCharacteristic = items[firstIndex]
            }
            guard let coreCharacteristic = coreCharacteristic else {
                return Result.error(BluetoothServiceError.notFound)
            }
            return Result.success(coreCharacteristic)
        case .error(let error):
            return Result.error(error)
        }
    }
    
    func discoverCharacteristic(for peripheral: Peripheral) -> Observable<Result<Characteristic, Error>> {
        discoverServices(for: peripheral)
        
        return discoveredServicesOutput.asObservable()
            .timeout(.seconds(4), scheduler: MainScheduler.instance)
            .map { [unowned self] result -> Service? in
                return self.filter(for: result)
            }.flatMap { [unowned self] service -> Observable<Result<[Characteristic], Error>> in
                guard let service = service else {
                    return Observable.empty()
                }
                self.discoverCharacteristics(for: service)
                return self.discoveredCharacteristicsOutput
            }
            .map { self.filter(for: $0)}
            .asObservable()
    }
}

enum BluetoothServiceError: Error {
    case unknown(Error)
    case notFound
}
