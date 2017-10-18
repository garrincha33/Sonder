//
//  CommentVC.swift
//  Sonder
//
//  Created by Richard Price on 02/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class CommentVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    
    var postId : String!
    var comments = [Comments]()
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comment"
        tableView.dataSource = self
        tableView.estimatedRowHeight = 77
        tableView.rowHeight = UITableViewAutomaticDimension
        sendButton.isEnabled = false
        empty()
        handleTextField()
        loadComments()
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func keyboardWillShow(_ notication: NSNotification) {
        let keyboardFrame = (notication.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        UIView.animate(withDuration: 0.3) {
            self.constraintToBottom.constant = keyboardFrame!.height
            self.view.layoutIfNeeded()
        }
        
    }
    
    func keyboardWillHide(_ notication: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.constraintToBottom.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    func loadComments() {
        Api.Post_Comment.REF_POST_COMMENTS.child(self.postId).observe(.childAdded, with: {
            snapshot in
            Api.Comment.observeComments(withPostId: snapshot.key, completion: { comment in
                self.fetchUser(uid: comment.uid, completed: {
                self.comments.append(comment)
                self.tableView.reloadData()
                })

            })

        })
    }
    
    func fetchUser(uid: String, completed: @escaping () -> Void) {
        Api.User.observeUser(withUid: uid, completion: {
            user in
            self.users.append(user)
            completed()

        })

    }
    
    func handleTextField() {
        commentTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: UIControlEvents.editingChanged)
    }
    
    func textFieldDidChange() {
        if let commentText = commentTextField.text, !commentText.isEmpty {
            sendButton.setTitleColor(.black, for: .normal)
            sendButton.isEnabled = true
            return
        }
        sendButton.setTitleColor(.lightGray, for: .normal)
        sendButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func sendCommentBtnPressed(_ sender: Any) {
        let commentsRef = Api.Comment.REF_COMMENTS
        let newCommentId = commentsRef.childByAutoId().key
        let newCommentRef = commentsRef.child(newCommentId)
        guard let currentUser = Api.User.CURRENT_USER else {
            return
        }
        let currentUserId = currentUser.uid
        newCommentRef.setValue(["uid": currentUserId, "commentText": commentTextField.text!]) { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            let postCommentRef = Api.Post_Comment.REF_POST_COMMENTS.child(self.postId).child(newCommentId)
            postCommentRef.setValue(true, withCompletionBlock: { (error, ref) in
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                    
                }
                
            })
            
            self.empty()
            self.view.endEditing(true)
        }
    }
    
    func empty() {
        self.commentTextField.text = ""
        sendButton.isEnabled = false
        sendButton.setTitleColor(.lightGray, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Comment_ProfileSegue" {
            let profileVC = segue.destination as! ProfileUserVC
            let userId = sender as! String
            profileVC.userId = userId
        }
    }
}

extension CommentVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCustomCell
        let comment = comments[indexPath.row]
        let user = users[indexPath.row]
        cell.comment = comment
        cell.user = user
        cell.delegate = self
        return cell

    }

}

extension CommentVC: CommentCustomCellDelegate {
    func goToUserProfileVC(userId: String) {
        performSegue(withIdentifier: "Comment_ProfileSegue", sender: userId)
    }
}
