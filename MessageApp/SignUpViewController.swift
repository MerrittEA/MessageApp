//
//  SignUpViewController.swift
//  MessageApp
//
//  Created by PotPie on 9/29/17.
//  Copyright © 2017 PotPie - CareerFoundry. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
    // Actions
    
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        guard let name = nameField.text,
        let email = emailField.text,
        let password = passwordField.text,
        name.characters.count > 0,
        email.characters.count > 0,
        password.characters.count > 0
        else {
            AlertClass.showAlert(message: "Enter a valid name, email and password please.", onController: self)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error { // definiing error in the function
                if error._code == AuthErrorCode.invalidEmail.rawValue {
                    AlertClass.showAlert(message: "Please enter a valid email", onController: self)
                } else if error._code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    AlertClass.showAlert(message: "Email already in use. Please enter a different email.", onController: self)
                } else {
                    AlertClass.showAlert(message: "Error: \(error.localizedDescription)", onController: self)
                }
                print(error.localizedDescription)
                return
            }
            if let user = user { // defining the user in the function
                self.setUserName(user: user, name: name)
            }
        }
    }
    
    // functions
    
    //creating the user name
    
    func setUserName(user: User, name: String) {
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        
        changeRequest.commitChanges() { (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            AuthenticationManager.sharedInstance.didLogIn(user: user)
            self.performSegue(withIdentifier: "UserTableView", sender: nil)
        }
    }
    
    // Loading
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
