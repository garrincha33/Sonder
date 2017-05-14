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
    
    
    
}
