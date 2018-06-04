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

    enum TaskType {
        case text
        case video
        case audio
        case photo
        
    }
    
    
    func getTaskType() -> Set<TaskType> {
        
        var taskType = Set<TaskType>()
        
        guard self.disableTask == false else {
            return taskType
        }
        
        
        if !self.disableVideo {
            taskType.insert(.video)
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
