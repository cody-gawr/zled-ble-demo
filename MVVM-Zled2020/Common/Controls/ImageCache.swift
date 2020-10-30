//
//  ImageCacheType.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/27/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit
import Combine

protocol ImageCacheType: class {
    // Returns the image associated with a given url
    func image(for url: URL) -> UIImage?
    // Inserts the image of the specified url in the cache
    func insertImage(_ image: UIImage?, for url: URL)
    // Removes the image of the specified url
    func removeImage(for url: URL)
    // Removes all images from the cache
    func removeAllImages()
    // Access the value associated with the given key for reading and writing
    subscript(_ url: URL) -> UIImage? { get set }
}

final class ImageCache {
    
    // 1st level cache, that contains encoded images
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
        return cache
    }()
    
    // 2nd level cache, that contains decoded images
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
    private let lock = NSLock()
    private let config: Config
    
    struct Config {
        let countLimit: Int
        let memoryLimit: Int
        
        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100MB
    }
    
    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
    
    static func storeImage(_ image: UIImage, forKey key: String, url: URL) {
        var dict = UserDefaults.standard.object(forKey: Constant.Strings.imageCache) as? [String: String]
        if dict == nil {
            dict = [String: String]()
        }
        dict![url.absoluteString] = key
        StorageService.store(image: image, forKey: key, withStorageType: .fileSystem)
        UserDefaults.standard.set(dict, forKey: Constant.Strings.imageCache)
    }
    
    static func loadImage(url: URL, completion: @escaping (URL, UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(url, nil)
                return
            }
            guard let data = data else {
                completion(url, nil)
                return
            }
            if let image = UIImage(data: data) {
                completion(url, image)
            }
        }
        task.resume()
    }
    static func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, _) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

extension ImageCache: ImageCacheType {
    func insertImage(_ image: UIImage?, for url: URL) {
        guard let image = image else { return removeImage(for: url) }
        let decodedImage = image.decodedImage()
        lock.lock(); defer { lock.unlock() }
        imageCache.setObject(image as AnyObject, forKey: url as AnyObject)
        decodedImageCache.setObject(decodedImage, forKey: url as AnyObject)
    }
    
    func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url as AnyObject)
        decodedImageCache.removeObject(forKey: url as AnyObject)
    }
    
    func image(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        // the best case scenario -> there is a decoded image
        if let decodedImage = decodedImageCache.object(forKey: url as AnyObject) as? UIImage {
            return decodedImage
        }
        // search for image data
        if let image = imageCache.object(forKey: url as AnyObject) as? UIImage {
            let decodedImage = image.decodedImage()
            decodedImageCache.setObject(image as AnyObject, forKey: url as AnyObject)
            return decodedImage
        }
        return nil
    }
    
    func removeAllImages() {
        imageCache.removeAllObjects()
        decodedImageCache.removeAllObjects()
    }
    
    subscript(url: URL) -> UIImage? {
        get {
            return image(for: url)
        }
        set {
            return insertImage(newValue, for: url)
        }
    }
}
