//
//  PostApi.swift
//  Sonder
//
//  Created by Richard Price on 05/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseDatabase

class PostApi {
    
    var REF_POSTS = FIRDatabase.database().reference().child("posts")
    
    func observePosts(completion: @escaping (Post) -> Void) {
        REF_POSTS.observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
                let newPost = Post.transformPost(dict: dict, key: snapshot.key)
                completion(newPost)
            }
            
        }
        
    }
    
    func observePost(withId id: String, completion: @escaping (Post) -> Void) {
        REF_POSTS.child(id).observeSingleEvent(of: FIRDataEventType.value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let post = Post.transformPost(dict: dict, key: snapshot.key)
                completion(post)
                
            }
        })
    }
}
