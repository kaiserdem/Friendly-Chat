//
//  GroupFeedCell.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 30.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var contentLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  
  func configureCell(profileImage: UIImage, email: String, content: String) {
    self.profileImage.image = profileImage
    self.emailLabel.text = email
    self.contentLabel.text = content
  }
  
}
