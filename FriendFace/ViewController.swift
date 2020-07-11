//
//  ViewController.swift
//  FriendFace
//
//  Created by Oliver Lippold on 11/07/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    var friends = [Friend]()
    var filteredFriends = [Friend]()
    let dataSource = FriendDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.dataChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        
        dataSource.fetch("https://www.hackingwithswift.com/samples/friendface.json")
        tableView.dataSource = dataSource
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find a friend"
        navigationItem.searchController = search
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        dataSource.filterText = searchController.searchBar.text
    }

}

