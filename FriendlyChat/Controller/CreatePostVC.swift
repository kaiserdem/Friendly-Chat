//
//  PostVC.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 26.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var profileImage: UIImageView!
  
  @IBOutlet weak var sendBtn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()

      textView.delegate = self
      sendBtn.bindToKeyboard()
    //  profileImage.bindToKeyboard()
    //  textView.bindToKeyboard()
    }
    

  @IBAction func closeBtnWasPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func sendBtnWasPressed(_ sender: Any) {
    if textView.text != nil && textView.text != "Say something here..." {
      sendBtn.isEnabled = false
      DataService.instance.uploadPost(withMessage: textView.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
        if isComplete {
          self.sendBtn.isEnabled = true
          self.dismiss(animated: true, completion: nil)
        } else {
          self.sendBtn.isEnabled = true
          print("There was an error")
        }
      }
    }
  }
  
}
extension CreatePostVC: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.text = ""
  }
}
