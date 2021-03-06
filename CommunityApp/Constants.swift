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

    
    static let ubiquityURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)
    
    
    static let comma = ","
    static let enter = "\n"
    
    static let cellReuseIdentifier = "cellReuseIdentifier"
    static let collectionViewLayout: UICollectionViewFlowLayout = {
            let viewLayout = UICollectionViewFlowLayout()
        viewLayout.minimumLineSpacing = 8
        viewLayout.minimumInteritemSpacing = 8
        viewLayout.itemSize = CGSize.init(width: 100, height: 100)
        viewLayout.estimatedItemSize = CGSize.init(width: 100, height: 100)
        viewLayout.sectionInset = UIEdgeInsets.init(top: -1, left: -1, bottom: -1, right: -1)
        return viewLayout
        
        
        //viewLayout.sectionInsetReference = UICollectionViewFlowLayout.SectionInsetReference.
        //2
        //let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        //let availableWidth = view.frame.width - paddingSpace
        //let widthPerItem = availableWidth / itemsPerRow
    }()
    
    
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
        static let EmailPage = "toEmailPage"
    }
    
    enum keyValue {
        static let username = "username"
        static let password = "password"
        static let personName = "personName"
        static let pageStyle = "pageStyle"
    }
    
    static private let defaultUsername = "CommunityLiving"
    static private let defaultPassword = "12345678"
    static private let defaultPersonName = "Client"
    
    
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
    
    
    
    static func getPersonName() -> String? {
        return UserDefaults.standard.string(forKey: Constant.keyValue.personName) ?? self.defaultPersonName
    }
    
 
    
    
    static func setUsername(_ username: String) {
        UserDefaults.standard.set(username, forKey: Constant.keyValue.username)
    }
    
    static func setPersonName(_ personName: String) {
         UserDefaults.standard.set(personName, forKey: Constant.keyValue.personName)
    }
    
    
    static func setPassword(_ password: String) {
        UserDefaults.standard.set(password, forKey: Constant.keyValue.password)
    }
    
//    static func setPageStyle(_ transitionStyle: UIPageViewController.TransitionStyle){
//        UserDefaults.standard.set(transitionStyle, forKey: Constant.keyValue.pageStyle)
//    }
    
//    static func getPageStyle() -> UIPageViewController.TransitionStyle {
//        if let pageStyle = UserDefaults.standard.object(forKey: Constant.keyValue.pageStyle) as? UIPageViewController.TransitionStyle {
//            return pageStyle
//        } else {
//            return UIPageViewController.TransitionStyle.scroll
//        }
//    }
   
    
}
