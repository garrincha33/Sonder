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
//    var allUsers: FIRDatabaseReference!
//    var alluids = [String]()
//    var allUsersArray = [String]()
    
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
   
    
//    func getAllUsers() {
//        
//        allUsers =  DataService.data.REF_USERS
//        allUsers.observeSingleEvent(of: .value, with: {(snapshot) in
//            var uidString = ""
//            if let dict1 = snapshot.value as? [String: AnyObject] {
//                self.alluids = [String] (dict1.keys)
//                for index in 0..<self.alluids.count{
//                    uidString=self.alluids[index]
//                    let temp = dict1[String(format: "%@", uidString)] as? [String: AnyObject]
//                    let checkString = temp!["username"] as? String
//                    if (checkString == nil)
//                    {
//                    }else
//                    {
//                        self.allUsersArray.append((checkString)!)
//                    }
//                    print("array is \(self.allUsersArray)")
//                    
//                    
//                }
//                
//            }
//            
//        })
//        
//        
//    }
//    
    
    
   
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

