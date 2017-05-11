//
//  HelperService.swift
//  Sonder
//
//  Created by Richard Price on 11/05/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseStorage
class HelperService {
    
    static func uploadDataToServer(data: Data, caption: String, onSucess: @escaping () -> Void) {
         let photoIdString = NSUUID().uuidString
        let storageRef = FIRStorage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("posts").child(photoIdString)
        storageRef.put(data, metadata: nil) {(metadata, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            let photoURL = metadata?.downloadURL()?.absoluteString
            self.sendDataToDatabase(photoUrl: photoURL!, caption: caption, onSuccess: onSucess)
        
        }

    }
    
    static func sendDataToDatabase(photoUrl: String, caption: String, onSuccess: @escaping () -> Void) {
        
        let newPostId = Api.Post.REF_POSTS.childByAutoId().key
        let newPostReference = Api.Post.REF_POSTS.child(newPostId)
        guard let currentUser = Api.User.CURRENT_USER else {
            return
        }
        let currentUserId = currentUser.uid
        newPostReference.setValue(["uid": currentUserId, "photoURL": photoUrl, "Caption": caption], withCompletionBlock: {
        (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            let myPostRef = Api.My_Posts.REF_MY_POSTS.child(currentUserId).child(newPostId)
            myPostRef.setValue(true, withCompletionBlock: {
            (error, ref) in
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
            })
            
            ProgressHUD.showSuccess("Success")
            onSuccess()
        
        })
        
    }
        
}
    

