//
//  AuthService.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 25.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
  static let instance = AuthService()
  
  func registerUser(withEmail email: String, andPassword password: String, userCreatingComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
    
    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
      guard let user = user else {
        userCreatingComplete(false, error)
        return
      }
      let userData = ["provider": user.user.uid, "email": user.user.email]
      DataService.instance.createDBUser(uid: user.user.uid, userData: userData)
      userCreatingComplete(true, nil)
    }
    
  }
  
  func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
    
    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
      guard let user = user else {
        loginComplete(false, error)
        return
      }
      loginComplete(true, nil)
    }

  }
}
