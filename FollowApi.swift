//
//  FollowApi.swift
//  Sonder
//
//  Created by Richard Price on 14/05/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FollowApi {
    
    var REF_FOLLOWERS = FIRDatabase.database().reference().child("followers")
    var REF_FOLLOWING = FIRDatabase.database().reference().child("following")
    
    func followAction(withUser id: String) {
        Api.My_Posts.REF_MY_POSTS.child(id).observeSingleEvent(of: .value, with: {
        snapshot in
            if let dict = snapshot.value as? [String: Any] {
                for key in dict.keys {
                    FIRDatabase.database().reference().child("feed").child(Api.User.CURRENT_USER!.uid).child(key).setValue(true)
                }
            }
        
        })
        REF_FOLLOWERS.child(id).child(Api.User.CURRENT_USER!.uid).setValue(true)
        REF_FOLLOWING.child(Api.User.CURRENT_USER!.uid).child(id).setValue(true)

    }
    
    func unFollowAction(withUser id: String) {
        REF_FOLLOWERS.child(id).child(Api.User.CURRENT_USER!.uid).setValue(NSNull())
        REF_FOLLOWING.child(Api.User.CURRENT_USER!.uid).child(id).setValue(NSNull())

    }
    
    func isFollowing(userId: String, completed: @escaping (Bool) -> Void) {
        REF_FOLLOWERS.child(userId).child(Api.User.CURRENT_USER!.uid).observeSingleEvent(of: .value, with: {
            snapshot in
            if let _ = snapshot.value as? NSNull {
                
                completed(false)
                
            } else {
                completed(true)
            }
        
        })
        
    }
}
