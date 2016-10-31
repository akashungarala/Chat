//
//  LoginViewController.swift
//  Chat
//
//  Created by Akash Ungarala on 10/27/16.
//  Copyright © 2016 Akash Ungarala. All rights reserved.
//

import UIKit
import ParseUI

class LoginViewController: UIViewController, UserDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let user = User.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        user.delegate = self
    }
    
    @IBAction func login(_ sender: UIButton) {
        if self.name.text == "" {
            alert("Enter User Name")
        } else if self.password.text == "" {
            alert("Enter Password")
        } else {
            self.user.login()
        }
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        var username = self.name.text
        var password = self.password.text
        var email = self.email.text
        if username == "" {
            alert("Enter User Name")
        } else if (username?.utf16.count)! < 4 {
            alert("User Name must be greater than 4 characters")
        } else if email == "" {
            alert("Enter Email Address")
        } else if (email?.utf16.count)! < 8 {
            alert("Email Address must be greater than 8 characters")
        } else if password == "" {
            alert("Enter Password")
        } else if (password?.utf16.count)! < 5 {
            alert("Password must be greater than 5 characters")
        } else {
            user.signup()
        }
    }
    
    @IBAction func nameChanged(_ sender: AnyObject) {
        user.name = name.text
    }
    
    @IBAction func emailChanged(_ sender: AnyObject) {
        user.email = email.text
    }
    
    @IBAction func passwordChanged(_ sender: AnyObject) {
        user.password = password.text
    }
    
    func alert(_ error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {}
    }
    
    func fail(sender: User, error: Error) {
        self.alert(error.localizedDescription)
    }
    
    func loginSuccess(sender: User) {
        performSegue(withIdentifier: "Login", sender: UIButton.self)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }

}
