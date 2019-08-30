//
//  GroupFeedVC.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 30.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {

  @IBOutlet weak var groupTitleLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var membersLabel: UILabel!
  
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var messageTextField: InsertTextField!
  @IBOutlet weak var sendBtnView: UIView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    sendBtnView.bindToKeyboard()
      
    }
    
  @IBAction func backBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func sendBtnWaaPressed(_ sender: Any) {
    
  }
  

}
