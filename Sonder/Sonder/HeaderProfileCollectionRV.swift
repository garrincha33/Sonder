//
//  HeaderProfileCollectionRV.swift
//  Sonder
//
//  Created by Richard Price on 20/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit


class HeaderProfileCollectionRV: UICollectionReusableView {
    
    @IBOutlet weak var profileImageName: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var myPostCountLable: UILabel!
    @IBOutlet weak var followingCountLable: UILabel!
    @IBOutlet weak var followersCountLable: UILabel!
    
    var user: User? {
        
        didSet {
            
            updateView()
            
        }
        
    }
    
    func updateView() {
        self.nameLable.text = user?.username
        let photoUrlString = user?.profileImageURL
        let photoUrl = URL(string: photoUrlString!)
        self.profileImageName.sd_setImage(with: photoUrl)
        
    }
}
