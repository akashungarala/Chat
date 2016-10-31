//
//  MessageCell.swift
//  Chat
//
//  Created by Akash Ungarala on 10/30/16.
//  Copyright © 2016 Akash Ungarala. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    
    var messageObject: Message? {
        didSet {
            message.text = messageObject?.message
            if let userName = messageObject?.name {
                name.text = userName
                name.isHidden = false
            } else {
                name.isHidden = true
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 30
        avatar.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        avatar.layer.borderWidth = 1
        name.preferredMaxLayoutWidth = name.frame.size.width
        message.preferredMaxLayoutWidth = message.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        name.preferredMaxLayoutWidth = name.frame.size.width
        message.preferredMaxLayoutWidth = message.frame.size.width
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
