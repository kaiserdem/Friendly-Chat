//
//  CreateGroupVC.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 29.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {

  @IBOutlet weak var titleTextField: InsertTextField!
  @IBOutlet weak var descriptionTextField: InsertTextField!
  @IBOutlet weak var emailSearchTextField: InsertTextField!
  @IBOutlet weak var groupMemberLbl: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var doneButton: UIButton!
  
  var emailArray = [String]()
  var chosenUserArray = [String]()
  
  override func viewDidLoad() {
        super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
    emailSearchTextField.delegate = self
    emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    doneButton.isHidden = true
  }
  
  @objc func textFieldDidChange() {
    if emailSearchTextField.text == "" {
      emailArray = []
      tableView.reloadData()
    } else {
      DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!) { (returnEmailArray) in
        self.emailArray = returnEmailArray
        self.tableView.reloadData()
      }
    }
  }
  @IBAction func coloseBtnWasPressed(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  @IBAction func doneBtnWasPressed(_ sender: Any) {
    if titleTextField.text != "" && descriptionTextField.text != "" {
      DataService.instance.getIds(forUserNames: chosenUserArray) { (idsArray) in
        var userIds = idsArray
        userIds.append((Auth.auth().currentUser?.uid)!)
        
        DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, handler: { (groupCreated) in
          if groupCreated {
            self.dismiss(animated: true, completion: nil)
          } else {
            print("Group could not be created. Please try again.")
          }
        })
      }
    }
  }
  
}
extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return emailArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell  = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return  UITableViewCell() }
    
    let profileImage = UIImage(named: "defaultProfileImage")
    
    if chosenUserArray.contains(emailArray[indexPath.row]) {
      cell.configureCell(profoleImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
    } else {
      cell.configureCell(profoleImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
    }
    
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
    if !chosenUserArray.contains(cell.emailLabel.text!) {
      chosenUserArray.append(cell.emailLabel.text!)
      groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
      doneButton.isHidden = false
    } else {
      chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLabel.text!})
      if chosenUserArray.count >= 1 {
        groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
      } else {
        groupMemberLbl.text = "add people to your group"
        doneButton.isHidden = true
      }
    }
  }
}
extension CreateGroupVC: UITextFieldDelegate {
  
}
