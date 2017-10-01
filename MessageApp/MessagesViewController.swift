//
//  MessagesViewController.swift
//  MessageApp
//
//  Created by PotPie on 9/29/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class MessagesViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    var displayName: String!
    var outgoingMessage: JSQMessageBubbleImage!
    var incomingMessage: JSQMessageBubbleImage!
    var ref: DatabaseReference!
    private var databaseHandle: DatabaseHandle!
    
    // privates
    
    private struct MessageProperties {
        static let messageType = "messages"
        static let senderID = "senderId"
        static let senderDisplayName = "senderDisplayName"
        static let text = "text"
        static let user = "user"
    }
    
    //Variables
    
    var messages = [JSQMessage]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        senderId = AuthenticationManager.sharedInstance.userId
        senderDisplayName = AuthenticationManager.sharedInstance.userName
        
        collectionView!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
