//
//  CommentVC.swift
//  Sonder
//
//  Created by Richard Price on 02/04/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


class CommentVC: UIViewController {
    
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.isEnabled = false
        empty()
        handleTextField()
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
    
    @IBAction func sendCommentBtnPressed(_ sender: Any) {
        let ref = FIRDatabase.database().reference()
        let commentsRef = ref.child("comments")
        let newCommentId = commentsRef.childByAutoId().key
        let newCommentRef = commentsRef.child(newCommentId)
        guard let currentUser = FIRAuth.auth()?.currentUser else {
            return
        }
        let currentUserId = currentUser.uid
        newCommentRef.setValue(["uid": currentUserId, "commentText": commentTextField.text!]) { (error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            self.empty()
        }
    }
    
    func empty() {
        self.commentTextField.text = ""
        sendButton.isEnabled = false
        sendButton.setTitleColor(.lightGray, for: .normal)
    }
}
