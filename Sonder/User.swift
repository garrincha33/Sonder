//
//  User.swift
//  Sonder
//
//  Created by Richard Price on 29/03/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation

class User {
    
    private var _email: String?
    private var _profileImageURL: String?
    private var _username: String?
    
    var email: String {
        
        set {
            
            self._email = newValue
            
        }
        
        get {
            
            if _email == nil {
                
                return "is nil"
                
            }
            return _email!
        }
        
    }
    
    var profileImageURL: String {
        
        set {
            
            self._profileImageURL = newValue
            
        }
        
        get {
            
            if _profileImageURL == nil {
                
                return "is nil"
                
            }
            return _profileImageURL!
        }
        
    }
    
    var username: String {
        
        set {
            
            self._username = newValue
            
        }
        
        get {
            
            if _username == nil {
                
                return "is nil"
                
            }
            return _username!
        }
        
    }
}

extension User {
    
    static func transformUserPost(dict: [String: Any]) -> User {
        let user = User()
        user.email = (dict["email"] as? String)!
        user.profileImageURL = (dict["profileImageURL"] as? String)!
        user.username = (dict["username"] as? String)!
        return user
        
    }
    
}
