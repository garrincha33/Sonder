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
    }
}
