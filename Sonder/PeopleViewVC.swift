//
//  PeopleViewVC.swift
//  Sonder
//
//  Created by Richard Price on 13/05/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class PeopleViewVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()
        
    }
    
    func loadUsers() {
        Api.User.observeUsers { (user) in
            self.isFollowing(userId: user.id, completed: { (value) in
                user.isFollowing = value
                self.users.append(user)
                self.tableView.reloadData()
            })
        }
    }
    
    func isFollowing(userId: String, completed: @escaping (Bool) -> Void) {
        
        Api.Follow.isFollowing(userId: userId, completed: completed)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileSegue" {
            let profileVC = segue.destination as! ProfileUserVC
            let userId = sender as! String
            profileVC.userId = userId
        }
    }
}

extension PeopleViewVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell", for: indexPath) as! PeopleTableViewCell
        let user = users[indexPath.row]
        cell.user = user
        cell.delegate = self
        return cell
        
    }
    
}

extension PeopleViewVC: PeopleTableViewCellDelegate {
    func goToProfileUserVC(userId: String) {
        performSegue(withIdentifier: "ProfileSegue", sender: userId)
    }
}
