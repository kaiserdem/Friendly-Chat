//
//  CreateGroupVC.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 29.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class CreateGroupVC: UIViewController {

  @IBOutlet weak var titleTextField: InsertTextField!
  @IBOutlet weak var descriptionTextField: InsertTextField!
  @IBOutlet weak var emailSearchTextField: InsertTextField!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var doneButton: UIButton!
  
  var emailArray = [String]()
  
  override func viewDidLoad() {
        super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
    emailSearchTextField.delegate = self
    emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    
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
    
    cell.configureCell(profoleImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
    return cell
  }
}
extension CreateGroupVC: UITextFieldDelegate {
  
}
