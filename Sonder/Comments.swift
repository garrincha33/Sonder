//
//  Comments.swift
//  Sonder
//
//  Created by Richard Price on 03/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation


class Comments {
    
    private var _commentText: String?
    private var _uid: String?
    
    var commentText: String {
        
        set {
            
            self._commentText = newValue
            
        }
        
        get {
            
            if _commentText == nil {
                
                return "is nil"
                
            }
            return _commentText!
        }
        
    }
    
    var uid: String {
        
        set {
            
            self._uid = newValue
            
        }
        
        get {
            
            if _uid == nil {
                
                return "is nil"
                
            }
            return _uid!
        }
        
    }

}

extension Comments {
    static func transformComments(dict: [String: Any]) -> Comments {
        let comment = Comments()
        comment.commentText = (dict["commentText"] as? String)!
        comment.uid = (dict["uid"] as? String)!
        return comment

    }
    
}
