//
//  ImageCache.swift
//  movies
//
//  Created by Joyce Rosario Batista on 07/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import Foundation
import UIKit

//This is a Singleton Class to save image in cache or get it from cache if already exists.
class ImageCache {
    private let cache = NSCache<NSString, UIImage>()
    
    static let shared = ImageCache()
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func cleanCachedImage(key: String) {
        if(cache.object(forKey: key as NSString) != nil) {
            cache.removeObject(forKey: key as NSString)
        }
    }
}
