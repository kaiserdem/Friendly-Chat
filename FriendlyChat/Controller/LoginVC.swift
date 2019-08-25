//
//  LoginVC.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 25.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

  @IBOutlet weak var emailField: InsertTextField!
  
  @IBOutlet weak var passwordField: InsertTextField!
  override func viewDidLoad() {
        super.viewDidLoad()
    emailField.delegate = self
    passwordField.delegate = self

    }
    
  @IBAction func singInBtnWasPressed(_ sender: Any) {
    if emailField.text != nil && passwordField.text != nil {
      AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!) { (success, loginError) in
        if success {
          self.dismiss(animated: true, completion: nil)
        } else {
          print(String(describing: loginError?.localizedDescription))
        }
        AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreatingComplete: { (success, registrationError) in
          if success {
            AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (success, nil) in
              self.dismiss(animated: true, completion: nil)
                print("Seccussefully register user")
            })
          } else {
            print(String(describing: registrationError?.localizedDescription))
          }
        })
      }
    }
  }
  
  @IBAction func closeBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
}
extension LoginVC: UITextFieldDelegate {
  
}
