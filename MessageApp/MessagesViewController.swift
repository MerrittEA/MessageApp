//
//  MessagesViewController.swift
//  MessageApp
//
//  Created by PotPie on 9/29/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController // can't get this to load right


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
        
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        setupMessageBubbles()
        
        ref = Database.database().reference()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingMessageBubbleImage
        } else {
            return incomingMessageBubbleImage
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView!.textColor = .white
        } else {
            cell.textView!.textColor = .black
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.item]
        switch message.senderId {
        //Here we are displaying everyones name above their message except for the "Senders"
        case senderId:
            return nil
        default:
            guard let senderDisplayName = message.senderDisplayName else {
                assertionFailure()
                return nil
            }
            return NSAttributedString(string: senderDisplayName)
            
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 20.0
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let messageRef = ref.child(MessageProperties.messageType).childByAutoId()
        let message = [
            MessageProperties.text: text!,
            MessageProperties.senderID: senderId!,
            MessageProperties.senderDisplayName: senderDisplayName!
        ]
        messageRef.setValue(message)
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        finishSendingMessage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messages.removeAll()
        databaseHandle = ref.child(MessageProperties.messageType).observe(.childAdded, with: { (snapshot) -> Void in
            if let value = snapshot.value as? [String:AnyObject] {
                let id = value[MessageProperties.senderID] as! String
                let text = value[MessageProperties.text] as! String
                let name = value[MessageProperties.senderDisplayName] as! String
                
                self.addMessage(id: id, text: text, name: name)
                self.finishReceivingMessage()
            }
        })
    }
    
    private func setupMessageBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingMessageBubbleImage = factory?.outgoingMessagesBubbleImage(
            with: UIColor(red:0.97, green:0.57, blue:0.01, alpha:1.00))
        incomingMessageBubbleImage = factory?.incomingMessagesBubbleImage(
            with: .jsq_messageBubbleLightGray())
    }
    
    func addMessage(id: String, text: String, name: String) {
        let message = JSQMessage(senderId: id, displayName: name, text: text)
        messages.append(message!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.ref.removeObserver(withHandle: databaseHandle)
    }
    
    @IBAction func signOut(sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            AuthenticationManager.sharedInstance.loggedIn = false
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError)")
        }
    }
}
