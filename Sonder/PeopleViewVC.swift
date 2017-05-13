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
        
        Api.User.observeUsers { (User) in
            
            self.users.append(User)
            self.tableView.reloadData()
            
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
        return cell
        
    }

}
