//
//  Constants.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-06-22.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation

class Constant {
    
    static let cellReuseIdentifier = "cellReuseIdentifier"
    
    
    
    enum segueID {
        static let JobViewer: String = "toJobViewer"
        static let TaskManager: String = "toTaskManager"
        static let JobEditor = "toJobEditor"
        static let JobManager = "toJobManager"
        static let Configure = "toConfigure"
        static let FrontPage = "toFrontPage"
        static let SignIn = "toSignIn"
        static let AudioRecorder = "toAudioTaker"
        static let NotificationEditor = "toNotificationEditor"
    }
    
    
    enum keyValue {
        static let username = "username"
        static let password = "password"
        static let email = "email"
        
    }
    
    static func getUsername() -> String {
        return UserDefaults.standard.string(forKey: Constant.keyValue.username)!

    }

    static func validateLogin(username: String, password: String) -> Bool {
        if username == Constant.getUsername() && password == Constant.getPassword() {
            return true
        }
        return false
    }
    
    static func getPassword() -> String {
        return UserDefaults.standard.string(forKey: Constant.keyValue.password)!
    }
    
  
    
    static func getEmail() -> String {
        return UserDefaults.standard.string(forKey: Constant.keyValue.email)!
    }
    
    static func setEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: keyValue.email)
    }
    
    
    static func setUsername(_ username: String) {
        UserDefaults.standard.set(username, forKey: keyValue.username)
    }
    
    
    static func setPassword(_ password: String) {
        UserDefaults.standard.set(password, forKey: keyValue.password)
    }
    
    
    
}
