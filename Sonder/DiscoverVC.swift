//
//  DiscoverVC.swift
//  Sonder
//
//  Created by Richard Price on 27/02/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class DiscoverVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTopPosts()
    }
    
    func loadTopPosts() {
        self.posts.removeAll()
        Api.Post.observeTopPosts { (post) in
            self.posts.append(post)
            self.collectionView.reloadData()
            
        }

    }

}

extension DiscoverVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiscoverCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
        
    }
}

extension DiscoverVC: UICollectionViewDelegateFlowLayout {
    
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
