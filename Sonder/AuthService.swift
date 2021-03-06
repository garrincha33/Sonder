//
//  AuthService.swift
//  Sonder
//
//  Created by Richard Price on 05/03/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

var allUsers: FIRDatabaseReference!
class AuthService {
    
    
    static func signIn(email: String, password: String, onSuccess: @escaping () ->  Void, onError: @escaping (_ errorMessage: String?) ->  Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            //callback to let users know when successful, @escaping means call back can be called after signInMethod returned, without it can only be called inside the method
            onSuccess()
            
        })
    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping () ->  Void, onError: @escaping (_ errorMessage: String?) ->  Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            let uid = user?.uid
            let storeRef = FIRStorage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("profile_image").child(uid!)
            storeRef.put(imageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                let profileImageUrl = metadata?.downloadURL()?.absoluteString
                self.setUserInfomation(profileImageUrl: profileImageUrl!, username: username, email: email, uid: uid!, onSucess: onSuccess)
                
            })
            
        })
        
    }

    static func setUserInfomation(profileImageUrl: String, username: String, email: String, uid: String, onSucess: @escaping() -> Void) {
        let ref = FIRDatabase.database().reference()
        let usersReference = ref.child("users")
        print(usersReference.description())
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username": username, "username_lowercase": username.lowercased(), "email": email, "profileImageURL":profileImageUrl ])
        onSucess()
        
    }
    
    static func logOut(onSucess: @escaping () -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        do {
            try FIRAuth.auth()?.signOut()
            onSucess()
        } catch let logoutError {
            onError(logoutError.localizedDescription)
            
        }
    }
}
