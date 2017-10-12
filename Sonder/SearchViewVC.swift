//
//  SearchViewVC.swift
//  Sonder
//
//  Created by Richard Price on 26/05/2017.
//  Copyright © 2017 twisted echo. All rights reserved.
//

import UIKit

class SearchViewVC: UIViewController {
    
    var searchBar = UISearchBar()
    var users: [User] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.frame.size.width = view.frame.size.width - 50
        let searchItem = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = searchItem

    }
    
    

    func doSearch() {
        if let searchText = searchBar.text?.lowercased() {
            self.users.removeAll()
            self.tableView.reloadData()
            Api.User.queryUsers(withText: searchText, completion: { (user) in
                self.isFollowing(userId: user.id, completed: { (value) in
                    user.isFollowing = value
                    self.users.append(user)
                    self.tableView.reloadData()
                    
                })
            })
        } 
    }
    
    func isFollowing(userId: String, completed: @escaping (Bool) -> Void) {
        Api.Follow.isFollowing(userId: userId, completed: completed)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Search_ProfileSegue" {
            let profileUserVC = segue.destination as! ProfileUserVC
            let userId = sender as! String
            profileUserVC.userId = userId
        }
    }
}

extension SearchViewVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        doSearch()

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        doSearch()

    }

}

extension SearchViewVC: UITableViewDataSource {
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

extension SearchViewVC: PeopleTableViewCellDelegate {
    func goToProfileUserVC(userId: String) {
        performSegue(withIdentifier: "Search_ProfileSegue", sender: userId)
    }
}
