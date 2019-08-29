//
//  AuthVC.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 25.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if Auth.auth().currentUser != nil {
      dismiss(animated: true, completion: nil)
    }
  }
    
  @IBAction func singInWithEmailBtnWasPresed(_ sender: Any) {
    let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
    present(loginVC!, animated: true, completion: nil)
  }
  
  
  @IBAction func facebookSingInWithEmailBtnWasPresed(_ sender: Any) {
  }
  @IBAction func googleSingInWithEmailBtnWasPresed(_ sender: Any) {
  }
  
}
