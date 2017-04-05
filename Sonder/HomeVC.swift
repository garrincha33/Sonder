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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var posts = [Post]()
    var users = [User]()
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CommentSegue" {
            let commentVC = segue.destination as! CommentVC
            let postId = sender as! String
            commentVC.postId = postId
        }
    }

    func loadPosts() {
        activityIndicatorView.startAnimating()
        Api.Post.observePosts { (newPost) in
            self.fetchUser(uid: newPost.uid, completed: {
                self.posts.append(newPost)
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            })
        }
    }
 
    func fetchUser(uid: String, completed: @escaping () -> Void) {
        Api.User.observeUser(withUid: uid, completion: {
            user in
            self.users.append(user)
            completed()
        })
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! HomeCustomCell
        let post = posts[indexPath.row]
        let user = users[indexPath.row]
        cell.post = post
        cell.user = user
        cell.homeVC = self
        return cell
        
    }
}

