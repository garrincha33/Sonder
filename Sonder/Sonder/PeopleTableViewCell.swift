//
//  PeopleTableViewCell.swift
//  Sonder
//
//  Created by Richard Price on 13/05/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

protocol PeopleTableViewCellDelegate {
    func goToProfileUserVC(userId: String)
}

class PeopleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    var delegate: PeopleTableViewCellDelegate?

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
        
        if user!.isFollowing! {
            configureUnFollowButton()
        } else {
            configureFollowButton()
        }

    }
    
    func setBorder() {
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor(red: 226/255, green: 228/255, blue: 232/255, alpha: 1).cgColor
        followButton.layer.cornerRadius = 5
        followButton.clipsToBounds = true
    }
    
    func configureFollowButton() {
        setBorder()
        followButton.setTitleColor(UIColor.yellow, for: UIControlState.normal)
        followButton.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        self.followButton.setTitle("follow", for: UIControlState.normal)
        followButton.addTarget(self, action: #selector(self.followAction), for: UIControlEvents.touchUpInside)
        
    }
    
    func configureUnFollowButton() {
        setBorder()
        followButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        followButton.backgroundColor = UIColor.clear
        self.followButton.setTitle("following", for: UIControlState.normal)
        followButton.addTarget(self, action: #selector(self.unFollowAction), for: UIControlEvents.touchUpInside)
    }
    
    func followAction() {
        if user!.isFollowing! == false {
            Api.Follow.followAction(withUser: (user?.id)!)
            configureUnFollowButton()
            user!.isFollowing! = true
        }
    }
    
    func unFollowAction() {
        if user!.isFollowing! == true {
            Api.Follow.unFollowAction(withUser: (user?.id)!)
            configureFollowButton()
            user!.isFollowing! = false
            
        }
    }
    func userNameTapped() {
        if let id = user?.id {
            delegate?.goToProfileUserVC(userId: id)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.userNameTapped))
        usernameLable.addGestureRecognizer(tap)
        usernameLable.isUserInteractionEnabled = true

    }
}
