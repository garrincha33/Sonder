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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.frame.size.width = view.frame.size.width - 50
        
        let searchItem = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = searchItem

    }
}

extension SearchViewVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("test")
        print(searchBar.text)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchBar.text)
    }

}
