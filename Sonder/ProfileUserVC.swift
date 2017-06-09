//
//  ProfileUserVC.swift
//  Sonder
//
//  Created by Richard Price on 08/06/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class ProfileUserVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var user: User!
    var posts: [Post] = []
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("userId = \(userId)")
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchUser()
        loadUserPosts()
    }
    

    
    func fetchUser() {
        Api.User.observeUser(withUid: userId) { (user) in
            self.user = user
            self.navigationItem.title = user.username
            self.collectionView.reloadData()
        }
    }
    
    func loadUserPosts() {
        
        Api.My_Posts.REF_MY_POSTS.child(userId).observe(.childAdded, with: {
        snapshot in
            Api.Post.observePost(withId: snapshot.key, completion: {
            post in
                self.posts.append(post)
                self.collectionView.reloadData()
            
            })
        
        })
        
    }

}

extension ProfileUserVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let post = posts[indexPath.row]
        cell.post = post
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

extension ProfileUserVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3 - 1, height: collectionView.frame.size.width / 3 - 1)
    }
    
}

