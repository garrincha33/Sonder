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
    
    var postRef: FIRDatabaseReference!
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
        
        Api.Post.REF_POSTS.child(post!.id).observeSingleEvent(of: .value, with: {
        snapshot in
            if let dict = snapshot.value as? [String: Any] {
                let post = Post.transformPost(dict: dict, key: snapshot.key)
                self.updateLike(post: post)
            }
        })
        Api.Post.REF_POSTS.child(post!.id).observe(.childChanged, with: {
            snapshot in
            if let value = snapshot.value as? Int {
                self.likeCountBtn.setTitle("\(value) likes", for: .normal)
            }
        
        })

    }
    
    func updateLike(post: Post) {
        print(post.isLiked)
        let imageName = post.likes == nil || !post.isLiked ? "likenofill" : "likeFill"
        likeImageView.image = UIImage(named: imageName)
        guard let count = post.likeCount else {
            return
        }
        if count != 0 {
            likeCountBtn.setTitle("\(count) likes", for: UIControlState.normal)
        }
        if let isOne = post.likeCount, isOne == 1 {
            likeCountBtn.setTitle("\(isOne) like", for: UIControlState.normal)
        }
        else if count == 0 {
            likeCountBtn.setTitle("be the first to like", for: UIControlState.normal)
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
        postRef = Api.Post.REF_POSTS.child(post!.id)
        incrementLikes(forRef: postRef)
     
    }
    
    func incrementLikes(forRef ref: FIRDatabaseReference) {
  
            ref.runTransactionBlock({ (currentData: FIRMutableData) -> FIRTransactionResult in
                if var post = currentData.value as? [String : AnyObject], let uid = FIRAuth.auth()?.currentUser?.uid {
                    print("value :-\(currentData.value)")
                    var likes: Dictionary<String, Bool>
                    likes = post["likes"] as? [String : Bool] ?? [:]
                    var likeCount = post["likeCount"] as? Int ?? 0
                    if let _ = likes[uid] {
                        // Unstar the post and remove self from stars
                        likeCount -= 1
                        likes.removeValue(forKey: uid)
                    } else {
                        // Star the post and add self to stars
                        likeCount += 1
                        likes[uid] = true
                    }
                    post["likeCount"] = likeCount as AnyObject?
                    post["likes"] = likes as AnyObject?
                    
                    // Set value and report transaction success
                    currentData.value = post
                    
                    return FIRTransactionResult.success(withValue: currentData)
                }
                return FIRTransactionResult.success(withValue: currentData)
            }) { (error, committed, snapshot) in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let dict = snapshot?.value as? [String: Any] {
                    let post = Post.transformPost(dict: dict, key: snapshot!.key)
                    self.updateLike(post: post)
                }
            }
        
      
        
    }
    
    func handleCommentTap() {
        if let id = post?.id {
            homeVC?.performSegue(withIdentifier: "CommentSegue", sender: id)
        }
    }
}
