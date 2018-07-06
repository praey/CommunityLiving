//
//  Constants.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-06-22.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
    static let cellReuseIdentifier = "cellReuseIdentifier"
    
    
    
    enum segueID {
        static let JobViewer: String = "toJobViewer"
        static let JobSelector: String = "toJobSelector"
        static let TaskManager: String = "toTaskManager"
        static let JobEditor = "toJobEditor"
        static let JobManager = "toJobManager"
        static let Configure = "toConfigure"
        static let FrontPage = "toFrontPage"
        static let SignIn = "toSignIn"
        static let AudioRecorder = "toAudioTaker"
        static let NotificationEditor = "toNotificationEditor"
        static let NotificationController = "toNotificationController"
    }
    
    enum keyValue {
        static let username = "username"
        static let password = "password"
        static let email = "email"
        static let pageStyle = "pageStyle"
    }
    
    static private let defaultUsername = "CommunityLiving"
    static private let defaultPassword = "12345678"
    static private let defaultEmail = "javonluke@live.com"
    
    static func getUsername() -> String {
        return UserDefaults.standard.string(forKey: Constant.keyValue.username) ?? self.defaultUsername
    }
    
    static func validateLogin(username: String, password: String) -> Bool {
        if username == Constant.getUsername() && password == Constant.getPassword() {
            return true
        }
        return false
    }
    
    static func getPassword() -> String? {
        return UserDefaults.standard.string(forKey: Constant.keyValue.password) ?? self.defaultPassword
    }
    
    
    
    static func getEmail() -> String? {
        return UserDefaults.standard.string(forKey: Constant.keyValue.email) ?? self.defaultEmail
    }
    
    static func setEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: Constant.keyValue.email)
    }
    
    
    static func setUsername(_ username: String) {
        UserDefaults.standard.set(username, forKey: Constant.keyValue.username)
    }
    
    
    static func setPassword(_ password: String) {
        UserDefaults.standard.set(password, forKey: Constant.keyValue.password)
    }
    
    static func setPageStyle(_ transitionStyle: UIPageViewController.TransitionStyle){
        UserDefaults.standard.set(transitionStyle, forKey: Constant.keyValue.pageStyle)
    }
    
    static func getPageStyle() -> UIPageViewController.TransitionStyle {
        if let pageStyle = UserDefaults.standard.object(forKey: Constant.keyValue.pageStyle) as? UIPageViewController.TransitionStyle {
            return pageStyle
        } else {
            return UIPageViewController.TransitionStyle.scroll
        }
    }
   
    
}
