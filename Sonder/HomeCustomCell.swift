//
//  HomeCustomCell.swift
//  Sonder
//
//  Created by Richard Price on 20/03/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

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
    
    func updateView() {
        
        captionLabel.text = post?.caption
        profileImageView.image = UIImage(named: "photo1")
        nameLabel.text = "Rich"
        if let photoUrlString = post?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            postImageView.sd_setImage(with: photoUrl)
            
        }
   }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}