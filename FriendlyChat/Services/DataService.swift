//
//  DataService.swift
//  FriendlyChat
//
//  Created by Kaiserdem on 25.08.2019.
//  Copyright © 2019 Kaiserdem. All rights reserved.
//

import Foundation
import Firebase
// https://friendlychat-b2921.firebaseio.com/
let DB_BASE = Database.database().reference()

class DataService {
  static let instance = DataService()
  
  private var _REF_BASE = DB_BASE
  private var _REF_USERS = DB_BASE.child("users")
  private var _REF_GROUPS = DB_BASE.child("groups")
  private var _REF_FEED = DB_BASE.child("feed")
  
  var REF_BASE: DatabaseReference {
    return _REF_BASE
  }
  
  var REF_USERS: DatabaseReference {
    return _REF_USERS
  }
  
  var REF_GROUPS: DatabaseReference {
    return _REF_GROUPS
  }
  
  var REF_FEED: DatabaseReference {
    return _REF_FEED
  }
  func createDBUser(uid: String, userData: Dictionary<String, Any>) {
    REF_USERS.child(uid).updateChildValues(userData)
  }
  func getUserName(forUID uid: String, handler: @escaping (_ userName: String) -> ()) {
    REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
      guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
      for user in userSnapshot {
        if user.key == uid {
          handler(user.childSnapshot(forPath: "email").value as! String)
        }
      }
    }
  }
  func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComlete: @escaping (_ status: Bool) -> ()) {
    if groupKey != nil {
      REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
      sendComlete(true)
    } else {
      REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
      sendComlete(true)
    }
  }
  func getAllFeedMessages(handler: @escaping (_ messages: [Message]) ->()) {
    var messageArray = [Message]()
    REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
      guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
      for message in feedMessageSnapshot {
        let content = message.childSnapshot(forPath: "content").value as! String
        let senderId = message.childSnapshot(forPath: "senderId").value as! String
        let message = Message(content: content, senderId: senderId)
        messageArray.append(message)
      }
      handler(messageArray)
    }
  }
  func getEmail(forSearchQuery query: String, handler: @escaping(_ email: [String]) -> ()) {
    var emailArray = [String]()
    REF_USERS.observe(.value) { (userShapshot) in
      guard let userShapshot = userShapshot.children.allObjects as? [DataSnapshot] else { return }
      for user in userShapshot {
        let email = user.childSnapshot(forPath: "email").value as! String
        
        if email.contains(query) == true && email != Auth.auth().currentUser?.email {
          emailArray.append(email)
          
        }
      }
      handler(emailArray)
    }
  }
  
  func getAllMessagesFor(desiderGroup: Group, handler: @escaping (_ messagesArray: [Message]) ->
    ()) {
    var groupMessageArray = [Message]()
    REF_GROUPS.child(desiderGroup.key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
      guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
      for groupMessage in groupMessageSnapshot {
        let content = groupMessage.childSnapshot(forPath: "content").value as! String
        let senderId = groupMessage.childSnapshot(forPath: "senderId").value as! String
        let groupMessage = Message(content: content, senderId: senderId)
        groupMessageArray.append(groupMessage)
      }
      handler(groupMessageArray)
    }
  }
  
  func getIds(forUserNames userNames:[String], handler: @escaping (_ uidArray: [String]) -> ()) {
    REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
      var idArray = [String]()
      guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
      for user in userSnapshot {
        let email = user.childSnapshot(forPath: "email").value as! String
        
        if userNames.contains(email) {
          idArray.append(user.key)
        }
      }
      handler(idArray)
    }
  }
  func createGroup(withTitle title: String, andDescription description: String, forUserIds ids: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
    
    REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
    
    handler(true)
  }
  
  func getEmailsFor(group: Group, handler: @escaping (_ emailArray: [String]) -> ()) {
    var emailArray = [String]()
    REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
      guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
      for user in userSnapshot {
        if group.members.contains(user.key) {
          let email = user.childSnapshot(forPath: "email").value as! String
          emailArray.append(email)
        }
      }
      handler(emailArray)
    }
  }
  
  func getAllGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
    
    var groupArray = [Group]()
    REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshot) in
      guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
      for group in groupSnapshot {
        let memberArray = group.childSnapshot(forPath: "members").value as! [String]
        if memberArray.contains((Auth.auth().currentUser?.uid)!) {
          let title = group.childSnapshot(forPath: "title").value as! String
          let description = group.childSnapshot(forPath: "description").value as! String
          let group = Group(title: title, groupDesc: description, key: group.key, memberCount: memberArray.count, members: memberArray)
          groupArray.append(group)
        }
      }
      handler(groupArray)
    }
  }
}
