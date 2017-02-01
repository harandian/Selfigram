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
    
    let imageURL: URL
    let user: User
    let comment: String
    
    init(imageURL: URL, user: User, comment: String) {
        self.imageURL = imageURL
        self.user = user
        self.comment = comment
    }
}
