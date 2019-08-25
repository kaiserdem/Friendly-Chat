//
//  AuthVC.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 25.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
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
