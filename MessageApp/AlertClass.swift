//
//  AlertClass.swift
//  MessageApp
//
//  Created by PotPie on 9/29/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import Foundation
import UIKit

class AlertClass {
    struct Properties {
        static let appName = "MessagesApp"
        static let okayMessage = "Okay"
    }
    
   
    class func showAlert(message: String, onController: UIViewController) {
        let alertController = UIAlertController(title: Properties.appName, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: Properties.okayMessage, style: .default, handler: nil))
        
        onController.present(alertController, animated: true, completion: nil)
    }
}
