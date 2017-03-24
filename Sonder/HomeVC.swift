//
//  HomeVC.swift
//  Sonder
//
//  Created by Richard Price on 27/02/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 521
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        loadPosts()
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
   
        do {
            
            try FIRAuth.auth()?.signOut()
            
        } catch let logOutError {
            
            print(logOutError)
            
        }
 
        let storyBoard = UIStoryboard(name: "Start", bundle: nil)
        let signInVC = storyBoard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
    
    func loadPosts() {
        DataService.data.REF_POSTS.observe(.childAdded) { (snapshot: FIRDataSnapshot) in
            print(Thread.isMainThread)
            if let dict = snapshot.value as? [String: Any] {
                let newPost = Post.transformPost(dict: dict)
                self.posts.append(newPost)
                print(self.posts)
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! HomeCustomCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
        
    }
}














