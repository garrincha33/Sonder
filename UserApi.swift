//
//  UserApi.swift
//  Sonder
//
//  Created by Richard Price on 05/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseDatabase

class UserApi {
    var REF_USERS = FIRDatabase.database().reference().child("users")
    func observeUser(withUid uid: String, completion: @escaping (User) -> Void) {
        
        REF_USERS.child(uid).observeSingleEvent(of: .value, with: { snapshot in
        
            if let dict = snapshot.value as? [String: Any] {
                
                let user = User.transformUserPost(dict: dict)
                completion(user)
                
            }
            
            
        })
        
    }
    
}
