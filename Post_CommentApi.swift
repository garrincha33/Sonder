//
//  Post_CommentApi.swift
//  Sonder
//
//  Created by Richard Price on 05/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Post_CommentApi {
   
   var REF_POST_COMMENTS = FIRDatabase.database().reference().child("post-comments")
    
    func observePostComments(withPostId id: String, completion: @escaping (Comments) -> Void ) {
        REF_POST_COMMENTS.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let newPostComment = Comments.transformComments(dict: dict)
                completion(newPostComment)
            }
            
        })
        
    }
    
}
