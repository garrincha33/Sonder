//
//  AuthService.swift
//  Sonder
//
//  Created by Richard Price on 05/03/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import Foundation
import FirebaseAuth
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
    
}
