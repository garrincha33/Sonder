//
//  HomeCustomCell.swift
//  Sonder
//
//  Created by Richard Price on 20/03/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var likeCountBtn: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: Post? {
        
        didSet {
            
            updateView()
            
        }
    }
    
    var user: User? {
        
        didSet {
            
            setupUserInfo()
            
        }
        
    }
    
  
    func updateView() {
        
        captionLabel.text = post?.caption
        if let photoUrlString = post?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            postImageView.sd_setImage(with: photoUrl)
            
        }
       // setupUserInfo()
    }
    
    func setupUserInfo() {
        
        nameLabel.text = user?.username
        if let photoUrlString = user?.profileImageURL {
            let photoUrl = URL(string: photoUrlString)
            profileImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholderImg"))
            
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholderImg")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        captionLabel.text = ""
    }
    
}
