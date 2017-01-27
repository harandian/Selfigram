//
//  Post.swift
//  Selfigram
//
//  Created by Hirad on 1/24/17.
//  Copyright © 2017 Hirad. All rights reserved.
//

import Foundation
import UIKit

class Post {
    
    let image: UIImage
    let user: User
    let comment: String
    
    init(image: UIImage, user: User, comment: String) {
        self.image = image
        self.user = user
        self.comment = comment
    }
}
