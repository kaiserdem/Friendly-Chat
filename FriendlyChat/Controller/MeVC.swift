//
//  MeVC.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 25.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

  
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.emailLabel.text = Auth.auth().currentUser?.email

  }
    
  @IBAction func singInOutWasPressed(_ sender: Any) {
    let loqoutPopup = UIAlertController(title: "Logout?", message: "Are you sure want to logout", preferredStyle: .actionSheet)
    
    let lououtAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
      do {
        try Auth.auth().signOut()
        let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
        self.present(authVC!, animated: true, completion: nil)
      } catch {
        print(error)
      }
    }
    loqoutPopup.addAction(lououtAction)
    present(loqoutPopup, animated: true, completion: nil)
  }
}
