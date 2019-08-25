//
//  InsertTextField.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 25.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
 // изменили цвет плейсхолдера
class InsertTextField: UITextField {

  private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
  
  override func awakeFromNib() {
    setupView()
    super.awakeFromNib()
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  func setupView() {
    let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
    self.attributedPlaceholder = placeholder
  }
}
