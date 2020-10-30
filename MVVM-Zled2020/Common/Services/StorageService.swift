//
//  FileService.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/27/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation
import UIKit

enum StorageService {
    
    static let fileManager = FileManager.default
    
    static var documentsURL: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func create(directory name: String = Constant.Strings.assetsDirectoryName) -> URL {
        let filePath = documentsURL.appendingPathComponent(name)
        if !fileManager.fileExists(atPath: filePath.path) {
            do {
                try fileManager.createDirectory(atPath: filePath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                NSLog("Couldn't create document directory")
            }
        }
        return filePath
    }
    
    static func filePath(forKey key: String) -> URL {
        let directoryURL = create()
        return directoryURL.appendingPathComponent(key + ".png")
    }
    
    static func store(image: UIImage, forKey key: String, withStorageType: StroageType) {
        if let data = image.pngData() {
            switch withStorageType {
            case .fileSystem:
                let filePath: URL = Self.filePath(forKey: key)
                do {
                    try data.write(to: filePath)
                } catch let err {
                    print("Saving file resulted in error: ", err)
                }
            case .userDefault:
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    }
    
    static func retriveImage(forKey key: String, withStorageType storageType: StroageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            let filePath = Self.filePath(forKey: key)
            if let fileData = fileManager.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        case .userDefault:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                return image
            }
        }
        return nil
    }
    
}

extension StorageService {
    
    enum StroageType {
        case fileSystem
        case userDefault
    }
}
