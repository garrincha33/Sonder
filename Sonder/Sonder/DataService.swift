//
//  DataService.swift
//  Sonder
//
//  Created by Richard Price on 26/02/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()
let STORGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let data = DataService()
    
    private var _REF_USERS = DB_BASE.child("users")
    
    private var _REF_POSTS = DB_BASE.child("posts")
    
    private var _STORAGE_PICS = STORGE_BASE.child("profile_images")
    
    var REF_USERS: FIRDatabaseReference {
        
        return _REF_USERS
        
    }
    
    var REF_POSTS: FIRDatabaseReference {
        
        return _REF_POSTS
        
    }
    
    var STORAGE_PICS: FIRStorageReference {
        
        return _STORAGE_PICS
        
    }
    
    
    
}
