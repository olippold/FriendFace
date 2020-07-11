//
//  FriendDataSource.swift
//  FriendFace
//
//  Created by Oliver Lippold on 11/07/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import Foundation
import UIKit

class FriendDataSource: NSObject, UITableViewDataSource, UISearchResultsUpdating {
    var friends = [Friend]()
    var filteredFriends = [Friend]()
    var dataChanged: (() -> Void)?
    
    func fetch(_ urlString: String) {
       let decoder = JSONDecoder()
       decoder.dateDecodingStrategy = .iso8601
        
       decoder.decode([Friend].self, fromUrl: urlString) { friends in
           self.friends = friends
           self.filteredFriends = friends
           self.dataChanged?()
       }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let friend = filteredFriends[indexPath.row]
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = friend.friendList
        return cell
    }
    
    var filterText: String? {
        didSet {
            filteredFriends = friends.matching(filterText)
            dataChanged?()
        }
    }
    
   
}
