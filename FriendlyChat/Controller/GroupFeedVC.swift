//
//  GroupFeedVC.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 30.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
  
  @IBOutlet weak var groupTitleLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var membersLabel: UILabel!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var messageTextField: InsertTextField!
  @IBOutlet weak var sendBtnView: UIView!
  
  var group: Group?
  var groupMessages = [Message]()
  
  func initGroupData(forGroup group: Group) {
    self.group = group
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    sendBtnView.bindToKeyboard()
    tableView.delegate = self
    tableView.dataSource = self
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    groupTitleLabel.text = group?.groupTitle
    DataService.instance.getEmailsFor(group: group!) { (returnedEmails) in
      self.membersLabel.text = returnedEmails.joined(separator: ", ")
    }
    DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
      DataService.instance.getAllMessagesFor(desiderGroup: self.group!, handler: { (returnedGroupMessages) in
        self.groupMessages = returnedGroupMessages
        self.tableView.reloadData()
        
        if self.groupMessages.count > 0 {
          self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
        }
      })
    }
  }
  
  @IBAction func backBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func sendBtnWaaPressed(_ sender: Any) {
    if messageTextField.text != "" {
      messageTextField.isEnabled = false
      sendButton.isEnabled = false
      DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.key) { (complete) in
        if complete {
          self.messageTextField.text = ""
          self.messageTextField.isEnabled = true
          self.sendButton.isEnabled = true
        }
      }
    }
  }
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return groupMessages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
    
    let message = groupMessages[indexPath.row]
    DataService.instance.getUserName(forUID: message.senderId) { (email) in
      cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
    }
    return cell
}

func numberOfSections(in tableView: UITableView) -> Int {
  return 1
}
}
