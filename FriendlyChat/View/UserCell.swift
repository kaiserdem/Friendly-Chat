//
//  UserCell.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 29.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

  @IBOutlet weak var checkImage: UIImageView!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var emailLabel: UILabel!
  
  func configureCell(profoleImage image: UIImage, email: String, isSelected: Bool){
    self.profileImage.image = image
    self.emailLabel.text = email
    if isSelected {
      self.checkImage.isHidden = false
    } else {
      self.checkImage.isHidden = true
    }
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
