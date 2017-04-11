//
//  Post.swift
//  Sonder
//
//  Created by Richard Price on 13/03/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseAuth

class Post {
    
    private var _caption: String?
    private var _photoUrl: String?
    private var _videoUrl: String?
    private var _uid: String?
    private var _id: String?
    private var _isLiked: Bool?
    public  var  likeCount : Int?
    public  var  likes: Dictionary<String, Any>?
    
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
        set {
            
            self._videoUrl = newValue
        }
        
        get {
            
            if _videoUrl == nil {
                
                return "is nil"
                
            }
            
            return _videoUrl!
        }
        
    }
    
    var uid: String {
        
        set {
            
            self._uid  = newValue
        }
        
        get {
            
            if _uid == nil {
                
                return "is nil"
                
            }
            return _uid!
        }
        
    }
    
    var id: String {
        
        set {
            
            self._id  = newValue
        }
        
        get {
            
            if _id == nil {
                
                return "is nil"
                
            }
            return _id!
        }
        
    }

    var isLiked: Bool {
        
        set {
            
            self._isLiked  = true
        }
        
        get {
            
            if _isLiked == nil {
                
                return false
                
            }
            return _isLiked!
        }
        
    }

}

extension Post {
    
    static func transformPost(dict: [String: Any], key: String) -> Post {
        let postPhoto = Post()
        postPhoto.caption = (dict["Caption"] as? String)!
        postPhoto.photoUrl = (dict["photoURL"] as? String)!
        postPhoto.uid = (dict["uid"] as? String)!
        postPhoto.id = key
        postPhoto.likeCount = (dict["likeCount"] as? Int)
        postPhoto.likes = (dict["likes"] as? Dictionary<String, Any>)
        if let currentUserId = FIRAuth.auth()?.currentUser?.uid {
            if postPhoto.likes != nil {
                postPhoto.isLiked = postPhoto.likes![currentUserId] != nil
            }
        }
        
        return postPhoto
  
    }
    
}
