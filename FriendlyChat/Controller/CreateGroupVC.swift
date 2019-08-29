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
  override func viewDidLoad() {
        super.viewDidLoad()

    }
    
  @IBAction func coloseBtnWasPressed(_ sender: Any) {
  }
  @IBAction func doneBtnWasPressed(_ sender: Any) {
  }
  
}
