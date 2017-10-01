//
//  UserTableViewController.swift
//  MessageApp
//
//  Created by PotPie on 9/29/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit
import Firebase


class UserTableViewController: UITableViewController {
    
    let userCellIdentifier = "UserCell"
    
    
    private var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: userCellIdentifier) else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: userCellIdentifier)
        cell.textLabel?.text = users[indexPath.row]
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messageView = MessagesViewController()
        messageView.displayName = user[indexPath.row]
        let messageViewNavigationController = UINavigationController(rootViewController: messageView)
        present(MessagesViewController, animated: true, completion: nil)
    }


}
