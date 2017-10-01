//
//  LoginViewController.swift
//  MessageApp
//
//  Created by PotPie on 9/29/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // Segues
    
    struct Storyboard {
        static let userSegue = "UserTableView"
    }
    
    // Outlets
    
    @IBOutlet weak var newAccoutTap: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    // Actions
    
    @IBAction func loginDidTap(_ sender: UIButton) {
        guard let email = emailField.text,
        let password = passwordField.text,
        email.characters.count > 0,
        password.characters.count > 0
            else {
                AlertClass.showAlert(message: "Please enter a email and a password", onController: self)
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) {(user, error) in
            if let error = error {
                if error._code == AuthErrorCode.userNotFound.rawValue {
                    AlertClass.showAlert(message: "There is no users with that account.", onController: self)
                } else if error._code == AuthErrorCode.wrongPassword.rawValue {
                    AlertClass.showAlert(message: "That is the incorrect password", onController: self)
                } else {
                    AlertClass.showAlert(message: "Error: \(error.localizedDescription)", onController: self)
                }
                print(error.localizedDescription)
                return
            }
            
            if let user = user {
                AuthenticationManager.sharedInstance.didLogIn(user: user)
                self.performSegue(withIdentifier: "UserTableView", sender: nil)
            }
        }
    }
    
    
    //loading
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
