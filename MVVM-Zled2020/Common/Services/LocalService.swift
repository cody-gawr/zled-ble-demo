//
//  LocalService.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/11/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import RxBluetoothKit
import RealmSwift

final class LocalService {
    
    public static var shared = LocalService()
    
    public func save(peripheral: Peripheral?) {
        let item = PeripheralItem(value: ["id": 1, "uuid": peripheral?.identifier.uuidString ?? ""])
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(item, update: .modified)
        }
    }
    
    public func save(accessToken: String) {
        let item = AccessTokenItem(value: ["id": 1, "accessToken": accessToken])
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(item, update: .modified)
        }
    }
    
    public func cached() {
        let realm = try! Realm()
        try! realm.write {
            let leds = TransformAPI.convert(leds: Common.shared.leds)
            let ctrls = TransformAPI.convert(ctrls: Common.shared.ctrlBits)
            let names = TransformAPI.convert(names: Common.shared.playbackNames)
            let item = CacheItem(value: ["id": 1, "leds": leds, "ctrls": ctrls, "names": names])
            realm.add(item, update: .modified)
        }
    }
    
    public func save(sequenceName: String) {
        // MARK: -Selected tab
        let tab: Int = Common.tab
        // MARK: -Current playback No
        let playback: Int = Common.playback[tab]
        let ctrlBits: [Int] = Common.shared.ctrlBits[tab][playback]
        let leds: [[Int]] = Common.shared.leds[tab][playback]
        let realm = try! Realm()
        try! realm.write {
            let result = TransformAPI.convertForLocal(ctrlBits: ctrlBits, leds: leds)
            let maxId: Int = realm.objects(SequenceItem.self).max(ofProperty: "id") as Int? ?? 0
            var id = maxId + 1
            if let itemWithSameName = realm.objects(SequenceItem.self).filter("sequenceName = '\(sequenceName)'").first {
                id = itemWithSameName.id
            }
            let item = SequenceItem(value: ["id": id, "tab": tab, "sequenceName": sequenceName, "dateTime": Date(timeIntervalSinceNow: 0), "ctrlBits": result.ctrlBits, "frames": result.leds])
            realm.add(item, update: .modified)
        }
    }
    
    public func save(tab: Int, sequenceName: String, ctrlBits: [Int], frames: [[Int]]) {
        let realm = try! Realm()
        try! realm.write {
            let result = TransformAPI.convertForLocal(ctrlBits: ctrlBits, leds: frames)
            let maxId = realm.objects(SequenceItem.self).max(ofProperty: "id") as Int? ?? 0
            var id = maxId + 1
            if let sequenceItemWithSameName = realm.objects(SequenceItem.self).filter("sequenceName = '\(sequenceName)'").first {
                id = sequenceItemWithSameName.id
            }
            let item = SequenceItem(value: ["id": id, "tab": tab, "sequenceName": sequenceName, "dateTime": Date(timeIntervalSinceNow: 0), "ctrlBits": result.ctrlBits, "frames": result.leds])
            realm.add(item, update: .modified)
        }
    }
    
    public func find(sequenceName: String) -> SequenceItem? {
        let realm = try! Realm()
        let items = realm.objects(SequenceItem.self).filter("sequenceName = '\(sequenceName)'")
        return items.first
    }
    
    public func getAllSequences() -> [SequenceItem] {
        let realm = try! Realm()
        return realm.objects(SequenceItem.self).toArray(type: SequenceItem.self)
    }
    
    public func getImage(_ url: URL) -> UIImage? {
        guard let dict = UserDefaults.standard.object(forKey: Constant.Strings.imageCache) as? [String: String] else {
            return nil
        }
        guard let key = dict[url.absoluteString] else {
            return nil
        }
        
        return StorageService.retriveImage(forKey: key, withStorageType: .fileSystem)
    }
    
    public func remove(_ item: SequenceItem) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(item)
        }
    }
}

extension LocalService {
    
    public var peripheral: PeripheralItem? {
        let realm = try! Realm()
        guard let item: PeripheralItem = realm.objects(PeripheralItem.self).first else {
            return nil
        }
        return item.uuid == "" ? nil : item
    }
    
    public var accessToken: String? {
        let realm = try! Realm()
        guard let item: AccessTokenItem = realm.objects(AccessTokenItem.self).first else {
            return nil
        }
        
        return item.accessToken
    }
    
    public var cache: CacheItem? {
        let realm = try! Realm()
        guard let item: CacheItem = realm.objects(CacheItem.self).first else {
            return nil
        }
        return item
    }
}
