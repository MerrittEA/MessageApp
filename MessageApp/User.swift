//
//  User.swift
//  MessageApp
//
//  Created by PotPie on 9/29/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import Foundation

class User {
    static let sharedInstance = User()
    
    var loggedIn = false
    var displayName: String = ""
    var userID: String = ""
    
    func update(loggedIn: Bool, displayName: String, userID: String) {
        self.loggedIn = loggedIn
        self.displayName = displayName
        self.userID = userID
    }
}
