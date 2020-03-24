//
//  ImageProperties.swift
//  test
//
//  Created by Максим Окунеев on 3/17/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit

struct ImageProperties {
    
    let key: String
    let data: Data
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        guard let data = image.pngData() else { return nil }
        self.data = data
    }
}
