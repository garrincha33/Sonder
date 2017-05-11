//
//  CommentApi.swift
//  Sonder
//
//  Created by Richard Price on 05/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CommentApi {
    
    var REF_COMMENTS = FIRDatabase.database().reference().child("comments")

    func observeComments(withPostId id: String, completion: @escaping (Comments) -> Void ) {
        REF_COMMENTS.child(id).observeSingleEvent(of: .value, with: {
            snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let newComment = Comments.transformComments(dict: dict)
                completion(newComment)
            }
        
        })

    }
}
