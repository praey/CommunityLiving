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
        
        if !self.disablePhoto {
            taskType.insert(.photo)
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
        let URLString = NSHomeDirectory() + "/Documents/Videos/" + self.video!
        print(URLString)
        let url = URL(fileURLWithPath: URLString)
        let playerItem = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: playerItem)
        // let player = AVPlayer(url: url)
        
//        let url = URL.init(string: NSHomeDirectory() + "/Documents/Videos/" + self.video!)
//        print(url!)
//        let player = AVPlayer(url: url!)
        return player
    }
    
    
    
    func startAnalytics() {}
    func saveAnalytics() {}
}
