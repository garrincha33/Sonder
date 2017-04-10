//
//  HomeCustomCell.swift
//  Sonder
//
//  Created by Richard Price on 20/03/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class HomeCustomCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var likeCountBtn: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    
    var homeVC: HomeVC?
    
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
        if let currentUser = FIRAuth.auth()?.currentUser {
            Api.User.REF_USERS.child(currentUser.uid).child("likes").child((post?.id)!).observeSingleEvent(of: .value, with: {
                
                snapshot in
                //nsnull = is a value, nil = isnt a value
                if let _ = snapshot.value as? NSNull {
                    self.likeImageView.image = UIImage(named: "likenofill")
                    
                } else {
                    
                    self.likeImageView.image = UIImage(named: "likeFill")
                    
                }
                
            })
        }
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleCommentTap))
        commentImageView.addGestureRecognizer(tap)
        commentImageView.isUserInteractionEnabled = true
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(self.handleImageTap))
        likeImageView.addGestureRecognizer(likeTap)
        likeImageView.isUserInteractionEnabled = true
   
    }
    func handleImageTap() {
        if let currentUser = FIRAuth.auth()?.currentUser {
            Api.User.REF_USERS.child(currentUser.uid).child("likes").child((post?.id)!).observeSingleEvent(of: .value, with: {
                snapshot in
                if let _ = snapshot.value as? NSNull {
                    Api.User.REF_USERS.child(currentUser.uid).child("likes").child((self.post?.id)!).setValue(true)
                    self.likeImageView.image = UIImage(named: "likeFill")
                } else {
                    Api.User.REF_USERS.child(currentUser.uid).child("likes").child((self.post?.id)!).removeValue()
                    self.likeImageView.image = UIImage(named: "likenofill")
                }
                
            })
        }
    }
    
    func handleCommentTap() {
        if let id = post?.id {
            homeVC?.performSegue(withIdentifier: "CommentSegue", sender: id)
        }
    }
}
