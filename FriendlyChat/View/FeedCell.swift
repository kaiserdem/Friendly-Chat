//
//  FeedCell.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 29.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  
  func configureCell(profileImage: UIImage, email: String, content: String) {
    self.profileImage.image = profileImage
    self.emailLabel.text = email
    self.contentLabel.text = content
  }
  
}
