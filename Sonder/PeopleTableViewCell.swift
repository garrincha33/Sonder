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
        
        if user!.isFollowing == true {
            self.followButton.setTitle("following", for: UIControlState.normal)
        } else {
            self.followButton.setTitle("follow", for: UIControlState.normal)
        }
        
        //followButton.addTarget(self, action: #selector(self.followAction), for: UIControlEvents.touchUpInside)
        followButton.addTarget(self, action: #selector(self.unFollowAction), for: UIControlEvents.touchUpInside)
    }
    
    func followAction() {
        Api.Follow.followAction(withUser: (user?.id)!)
        
    }
    
    func unFollowAction() {
        Api.Follow.unFollowAction(withUser: (user?.id)!)
        
    }
    
}
