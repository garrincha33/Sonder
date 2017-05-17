//
//  FeedApi.swift
//  Sonder
//
//  Created by Richard Price on 16/05/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FeedApi {
    
    var REF_FEED = FIRDatabase.database().reference().child("feed")
    
    func observeFeed(withId id: String, completion: @escaping (Post) -> Void) {
        REF_FEED.child(id).observe(.childAdded, with: {
        snapshot in
            let key = snapshot.key
            Api.Post.observePost(withId: key, completion: { (post) in
                completion(post)
                
            })
        
        })
    }
    
    func observeFeedRemove(withId id: String, completion: @escaping (Post) -> Void) {
        REF_FEED.child(id).observe(.childRemoved, with: {
        snapshot in
            let key = snapshot.key
            Api.Post.observePost(withId: key, completion: { (post) in
                completion(post)
            })
        })
    }
}
