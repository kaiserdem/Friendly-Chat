//
//  ShadowView.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 25.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class ShadowView: UIView {

  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  func setupView() {
    self.layer.shadowOpacity = 0.75
    self.layer.shadowRadius = 5
    self.layer.shadowColor = UIColor.black.cgColor
  }

}
