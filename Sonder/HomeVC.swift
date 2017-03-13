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

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
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
}

func loadPosts() {
    
    FIRDatabase.database().reference().child("posts").observe(.childAdded) { (snapshot: FIRDataSnapshot) in
     
        print(snapshot.value)
        
    }
}

extension HomeVC: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.backgroundColor = UIColor.red
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
        
    }
    
    
}














