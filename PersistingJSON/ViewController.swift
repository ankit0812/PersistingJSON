//
//  ViewController.swift
//  PersistingJSON
//
//  Created by KingpiN on 17/07/19.
//  Copyright © 2019 KingpiN. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let store = DataStore.shared
    
    var users = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        store.requestUsers { [weak self] (users) in
            self?.users = users
            print(users.count)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < users.count else { return UITableViewCell() }
        let currentUser = users[indexPath.row]
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = currentUser.name + " is \(currentUser.age) years old"
        cell.detailTextLabel?.text = "\(currentUser.id)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

