//
//  DataModel.swift
//  Chat
//
//  Created by Akash Ungarala on 10/30/16.
//  Copyright © 2016 Akash Ungarala. All rights reserved.
//

import Foundation
import Parse

protocol UserDelegate: class {
    func fail(sender: User, error: Error)
    func loginSuccess(sender: User)
}

class User: NSObject {
    
    var name: String?
    var email: String?
    var password: String?
    var pfUser: PFUser?
    var currentUser: PFUser?
    
    weak var delegate: UserDelegate?
    
    static let sharedInstance = User()
    
    private override init() {}
    
    func signup() {
        pfUser = PFUser()
        pfUser?.username = name
        pfUser?.password = password
        pfUser?.email = email
        pfUser?.signUpInBackground { block in
            if let error = block.1 {
                self.delegate?.fail(sender: self, error: error)
            } else {
                let success = block.0
                if success {
                    self.login()
                }
            }
        }
    }
    
    func login() {
        PFUser.logInWithUsername(inBackground: name!, password: password!) { block in
            if let error = block.1 {
                self.delegate?.fail(sender: self, error: error)
            } else {
                self.pfUser = block.0
                self.currentUser = block.0
                self.delegate?.loginSuccess(sender: self)
            }
        }
    }
    
}

class Message: NSObject {
    var message: String!
    var name: String!
    var avatar: String!
}
