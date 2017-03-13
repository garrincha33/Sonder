//
//  Post.swift
//  Sonder
//
//  Created by Richard Price on 13/03/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation

class Post {
    
    private var _caption: String
    private var _photoUrl: String
    
    init(caption: String, photoUrl: String) {
        self._caption = caption
        self._photoUrl = photoUrl
    }
    
    var caption: String {
        return _caption
    }
    
    var photoUrl: String {
        return _photoUrl
    }

}
