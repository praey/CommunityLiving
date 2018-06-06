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

    private let audioFilePath = NSHomeDirectory() + "/Documents/Audios/"
    private let videoFilePath = NSHomeDirectory() + "/Documents/Videos/"
    private let photoFilePath = NSHomeDirectory() + "/Documents/Images/"
    
    
    enum TaskType {
        case text
        case video
        case audio
        case photo
    }
    
    enum FileType {
        case Photo
        case Video
        case Audio
        case Text
    }
    
    func getTaskType() -> Set<TaskType> {
        
        var taskType = Set<TaskType>()
        
        guard self.disableTask == false else {
            return taskType
        }
        
        
        if !self.disableVideo && ifFileExists(fileType: .Video) {
            taskType.insert(.video)
        }
        
        if !self.disablePhoto && ifFileExists(fileType: .Photo) {
            taskType.insert(.photo)
        }
        
        if !self.disableAudio && ifFileExists(fileType: .Audio) {
            taskType.insert(.audio)
        }
        
        
        
        return taskType
        
        
    }
    
 
    
    func ifFileExists(fileType: FileType) -> Bool {
        return CoreDataManager.database.ifFileExists(task: self, fileType: fileType)
    }
    
    
    
    func getAudio() -> URL {
        let URLString = audioFilePath + self.audio!
        let url = URL(fileURLWithPath: URLString)
        return url
    }
    
    func getPhoto() -> UIImage {
        let photo = UIImage.init(contentsOfFile: photoFilePath + self.photo!)
        return photo!
    }
    
    func getText() -> String {
        return self.text ?? "default"
    }
    
    func getVideo() -> AVPlayer {
        let URLString = videoFilePath + self.video!
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
