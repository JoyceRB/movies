//
//  Extensions.swift
//  movies
//
//  Created by Joyce Rosario Batista on 07/05/2020.
//  Copyright © 2020 Joyce Rosario Batista. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(fromUrlString urlString: String) {
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            return
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: URL(string:urlString)!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.image = image
                            ImageCache.shared.save(image: image, forKey: urlString)
                        }
                    }
                }
            }
        }
    }
}
