//
//  GroupsVC.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 25.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

  @IBOutlet weak var groupsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    groupsTableView.delegate = self
    groupsTableView.dataSource = self
  }
  
}
extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = groupsTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
    
    cell.configureCell(title: "Nerd Hard", description: "The nerdies nerds around.", memberCount: 3)
    return cell
    }
  
  
}
