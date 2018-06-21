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
    
    var thumbnail: UIImage? {
        get {
            if ifFileExists(filePath: .photo) {
                return getPhoto()
            } else if ifFileExists(filePath: .video) {
                do {
                    let url = URL(fileURLWithPath: self.videoFilePath + self.video!)
                    let asset = AVAsset.init(url: url)
                    let imgGenerator = AVAssetImageGenerator(asset: asset)
                
                    let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                    let uiImage = UIImage(cgImage: cgImage)
                    return uiImage
                } catch {
                    print("Error with imageGenerator for thumbanil")
                }
               
            }
            print("had to print a black page")
            return nil
        }
    }
    
 
    
    func getTaskType() -> Set<TaskType> {
        
        var taskType = Set<TaskType>()
        
        guard self.disableTask == false else {
            return taskType
        }
        
        
        if !self.disableVideo && ifFileExists(filePath: .video) {
            taskType.insert(.video)
        }
        
        if !self.disablePhoto && ifFileExists(filePath: .photo) {
            taskType.insert(.photo)
        }
        
        if !self.disableAudio && ifFileExists(filePath: .audio) {
            taskType.insert(.audio)
        }
        
        if !self.disableText, self.text != nil {
           taskType.insert(.text)
        }
        return taskType
    }
    
 
    
    func resourceExists(filePath: TaskType) -> Bool {
        
        
          var path: String!

        switch filePath {
            case .video:
            path = videoFilePath + self.video!

            case .audio:
            path = audioFilePath + self.audio!
            case .photo:
               path = photoFilePath + self.photo!
            default:
            print("file wasn't located - something went wrong")
            return false
        }
        return CoreDataManager.database.ifExists(filePath: path)


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
        player.isMuted = true
        // let player = AVPlayer(url: url)
        
//        let url = URL.init(string: NSHomeDirectory() + "/Documents/Videos/" + self.video!)
//        print(url!)
//        let player = AVPlayer(url: url!)
        return player
    }
    
    
    
    func startAnalytics() {}
    func saveAnalytics() {}
}
