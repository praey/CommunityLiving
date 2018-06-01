//
//  Task+CoreDataClass.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/5/23.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit
import AVFoundation


public class Task: NSManagedObject {

    func getTaskType() -> [Bool] {
        let taskType: [Bool] = [false,false,false,false]
        
        if self.disableTask {
            return taskType
        }
        
        if !self.disableText {
            
        }
        
        return taskType
        
        
    }
    
    func getPhoto() -> UIImage {
        let photo = UIImage.init(contentsOfFile: NSHomeDirectory() + "/Documents/Images/" + self.photo!)
        return photo!
    }
    
    func getText() -> String {
        return "default"
    }
    
    func getVideo() -> AVPlayer {
        let url = URL.init(string: NSHomeDirectory() + "/Documents/Videos/" + self.video!)
        let player = AVPlayer(url: url!)
        return player
    }
    
    func startAnalytics() {}
    func saveAnalytics() {}
}
