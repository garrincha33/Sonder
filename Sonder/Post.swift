//
//  Post.swift
//  Sonder
//
//  Created by Richard Price on 13/03/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation

class Post {
    
    private var _caption: String?
    private var _photoUrl: String?
    private var _videoUrl: String?
    
    init() {
        
        
        
    }
    
//    init(caption: String, photoUrl: String) {
//        self._caption = caption
//        self._photoUrl = photoUrl
//        
//    }
//    
//    init(caption: String, videoUrl: String) {
//        
//        self._caption = caption
//        self._videoUrl = videoUrl
//    }
//    
    
    var caption: String {
        
        set {
            
            self._caption  = newValue
        }
        
        get {
            
            if _caption == nil {
                
                return "is nil"
                
            }
            return _caption!
        }
        
    }
    
    var photoUrl: String {
        
        set {
            
            self._photoUrl = newValue
        }
        
        get {
            
            if _photoUrl == nil {
                
                return "is nil"

            }
            
            return _photoUrl!
        }
        
    }
    
    var videoUrl: String {
        return _videoUrl!
        
    }

}

extension Post {
    
    static func transformPost(dict: [String: Any]) -> Post {
        
        let postPhoto = Post()
        postPhoto.caption = (dict["Caption"] as? String)!
        postPhoto.photoUrl = (dict["photoURL"] as? String)!
        return postPhoto
  
    }
    
}
