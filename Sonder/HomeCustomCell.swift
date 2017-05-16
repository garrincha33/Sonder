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
            self.updateLike(post: post!)
    }
    
    func updateLike(post: Post) {
        let imageName = post.likes == nil || !post.isLiked ? "likenofill" : "likeFill"
        likeImageView.image = UIImage(named: imageName)
        guard let count = post.likeCount else {
            return
        }
        if count != 0 {
            likeCountBtn.setTitle("\(count) likes", for: UIControlState.normal)
        } else {
            likeCountBtn.setTitle("Be the first like this", for: UIControlState.normal)
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
        //pass by reference update like here for smoother user experience
        Api.Post.incrementLikes(postId: post!.id, onSucess: { (post) in
            self.updateLike(post: post)
            self.post?.likes = post.likes
            self.post?.isLiked = post.isLiked
            self.post?.likeCount = post.likeCount
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    
    
    func handleCommentTap() {
        if let id = post?.id {
            homeVC?.performSegue(withIdentifier: "CommentSegue", sender: id)
        }
    }
}
