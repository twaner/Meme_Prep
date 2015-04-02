//
//  Meme.swift
//  Meme_prep
//
//  Created by Taiowa Waner on 3/29/15.
//  Copyright (c) 2015 Taiowa Waner. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject {
    let topText: String
    let bottomText: String
    let image: UIImage
    let memedImage: UIImage
    
    init(bottomText: String, topText: String, image: UIImage, memedImage: UIImage) {
        self.bottomText = bottomText
        self.topText = topText
        self.image = image
        self.memedImage = memedImage
    }
    
}