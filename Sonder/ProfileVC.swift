//
//  ProfileVC.swift
//  Sonder
//
//  Created by Richard Price on 27/02/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var user: User!
    var posts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        fetchUser()
        fetchMyPosts()
    }
    
    func fetchUser() {
        Api.User.observeCurrentUser { (user) in
            self.user = user
            self.collectionView.reloadData()
        }
    }
    
    func fetchMyPosts() {
        guard let currentUser = FIRAuth.auth()?.currentUser else {
            return
        }
        Api.My_Posts.REF_MY_POSTS.child(currentUser.uid).observe(.childAdded, with: {
        snapshot in
            Api.Post.observePost(withId: snapshot.key, completion: {
            post in
                print(post.id)
                self.posts.append(post)
                self.collectionView.reloadData()
            
            })
        })
    }
}


extension ProfileVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderProfileCollectionRV", for: indexPath) as! HeaderProfileCollectionRV
        if let user = self.user {
            headerViewCell.user = user
        }
        
        return headerViewCell
        
    }
}
