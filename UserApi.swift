//
//  UserApi.swift
//  Sonder
//
//  Created by Richard Price on 05/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class UserApi {
    var REF_USERS = FIRDatabase.database().reference().child("users")
    
    func observeUser(withUid uid: String, completion: @escaping (User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value, with: { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let user = User.transformUserPost(dict: dict, key: snapshot.key)
                completion(user)
            }
        })
    }
    
    func observeCurrentUser(completion: @escaping (User) -> Void) {
        guard let currentUser = FIRAuth.auth()?.currentUser else {
            return
        }
        REF_USERS.child(currentUser.uid).observeSingleEvent(of: .value, with: { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let user = User.transformUserPost(dict: dict, key: snapshot.key)
                completion(user)
            }
        })
    }
    
    func observeUsers(completion: @escaping (User) -> Void) {
        
        REF_USERS.observe(.childAdded, with: {
        snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let user = User.transformUserPost(dict: dict, key: snapshot.key)
                completion(user)
            }
 
        })
        
    }
    
    var CURRENT_USER: FIRUser? {
        if let currenrUser = FIRAuth.auth()?.currentUser {
            return currenrUser
        }
        return nil
    }
    
    var REF_CURRENT_USER: FIRDatabaseReference? {
        
        guard let currentUser = FIRAuth.auth()?.currentUser else {
            return nil
        }
        
        return REF_USERS.child(currentUser.uid)
        
    }
    
    
}
