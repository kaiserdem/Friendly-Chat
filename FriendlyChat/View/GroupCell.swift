//
//  GroupCell.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 29.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

  @IBOutlet weak var memberCountLabel: UILabel!
  @IBOutlet weak var groupDescriptionLabel: UILabel!
  @IBOutlet weak var groupTitleLabel: UILabel!
  
  
  
  func configureCell(title: String, description: String, memberCount: Int) {
    self.groupTitleLabel.text = title
    self.groupDescriptionLabel.text = description
    self.memberCountLabel.text = "\(memberCount) members."
  }
}
