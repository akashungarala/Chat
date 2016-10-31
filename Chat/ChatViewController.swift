//
//  ChatViewController.swift
//  Chat
//
//  Created by Akash Ungarala on 10/27/16.
//  Copyright © 2016 Akash Ungarala. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var message: UITextField!
    
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.refresh), userInfo: nil, repeats: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        if let message = (messages?[indexPath.row]) {
            cell.messageObject = message
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = self.messages {
            return messages.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func refresh() {
        let query = PFQuery(className: "Message")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground { block in
            let error = block.1
            if error == nil {
                let objects = block.0
                if let objects = objects {
                    var messages: [Message] = []
                    var message: Message
                    for object in objects {
                        message = Message()
                        if let text = object["text"] as? String {
                            message.message = text
                            if let user = object["user"] as? PFUser {
                                message.name = user.username
                            }
                            messages.append(message)
                        }
                    }
                    self.messages = messages
                    self.tableView.reloadData()
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if self.message.text == nil || self.message.text == "" {
            return
        }
        let message = PFObject(className: "Message")
        message["text"] = self.message.text
        message["user"] = User.sharedInstance.currentUser
        message.saveInBackground { block in
            if (block.0) {
                self.message.text = ""
            } else {
                print(block.1?.localizedDescription)
            }
        }
    }

}
