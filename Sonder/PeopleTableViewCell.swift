//
//  PeopleTableViewCell.swift
//  Sonder
//
//  Created by Richard Price on 13/05/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var user: User? {
        
        didSet {
            
            updateView()
            
        }

    }
    
    func updateView() {
        usernameLable.text = user?.username
        if let photoUrlString = user?.profileImageURL {
            let photoUrl = URL(string: photoUrlString)
            profileImage.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholderImg"))
  
        }
        
        //followButton.addTarget(self, action: #selector(self.followAction), for: UIControlEvents.touchUpInside)
        followButton.addTarget(self, action: #selector(self.unFollowAction), for: UIControlEvents.touchUpInside)
    }
    
    func followAction() {
        Api.Follow.REF_FOLLOWERS.child(user!.id).child(Api.User.CURRENT_USER!.uid).setValue(true)
        Api.Follow.REF_FOLLOWING.child(Api.User.CURRENT_USER!.uid).child(user!.id).setValue(true)
    }
    
    func unFollowAction() {
        Api.Follow.REF_FOLLOWERS.child(user!.id).child(Api.User.CURRENT_USER!.uid).setValue(NSNull())
        Api.Follow.REF_FOLLOWING.child(Api.User.CURRENT_USER!.uid).child(user!.id).setValue(NSNull())
        
    }
    
}
