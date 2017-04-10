//
//  CommentCustomCell.swift
//  Sonder
//
//  Created by Richard Price on 02/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class CommentCustomCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var commentLable: UILabel!
    
    var comment: Comments? {
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
        commentLable.text = comment?.commentText
        
    }
    
    func setupUserInfo() {
        usernameLable.text = user?.username
        if let photoUrlString = user?.profileImageURL {
            let photoUrl = URL(string: photoUrlString)
            profileImageView.sd_setImage(with: photoUrl, placeholderImage: UIImage(named: "placeholderImg"))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        usernameLable.text = ""
        commentLable.text = ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: "placeholderImg")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
