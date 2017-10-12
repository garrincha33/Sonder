//
//  HomeVC.swift
//  Sonder
//
//  Created by Richard Price on 27/02/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
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
        //getAllUsers()
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        AuthService.logOut(onSucess: {
            let storyBoard = UIStoryboard(name: "Start", bundle: nil)
            let signInVC = storyBoard.instantiateViewController(withIdentifier: "SignInViewController")
            self.present(signInVC, animated: true, completion: nil)
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CommentSegue" {
            let commentVC = segue.destination as! CommentVC
            let postId = sender as! String
            commentVC.postId = postId
        }
        
        //seperate segue when touching username in home view
        if segue.identifier == "Home_ProfileSegue" {
            let profileVC = segue.destination as! ProfileUserVC
            let userId = sender as! String
            profileVC.userId = userId
        }
    }

    func loadPosts() {
        
        Api.Feed.observeFeed(withId: Api.User.CURRENT_USER!.uid) { (post) in
            self.fetchUser(uid: post.uid, completed: {
                self.posts.append(post)
                self.tableView.reloadData()
            })
        }
        //activityIndicatorView.startAnimating()
        Api.Feed.observeFeedRemove(withId: Api.User.CURRENT_USER!.uid) { (post) in
            self.posts = self.posts.filter { $0.id != post.id }
            self.users = self.users.filter { $0.id != post.uid }
            self.tableView.reloadData()
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
        cell.delegate = self
        return cell
        
    }
}

extension HomeVC: HomeCustomCellDelegate {
    func gotoCommentVC(postId: String) {
        performSegue(withIdentifier: "CommentSegue", sender: postId)
    }
    
    func gotoUserProfile(userId: String) {
        performSegue(withIdentifier: "Home_ProfileSegue", sender: userId)
    }
}

