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
    
    
    
    var thumbnail: UIImage? {
        get {
            if ifFileExists(filePath: .photo) {
                return getPhoto()
           }
            
            /*else if ifFileExists(filePath: .video) {
                do {
                    let url = URL(fileURLWithPath: getPath(.video)!)
                    let asset = AVAsset.init(url: url)
                    let imgGenerator = AVAssetImageGenerator(asset: asset)
                
                    let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                    let uiImage = UIImage(cgImage: cgImage)
                    return uiImage
                } catch {
                    print("Error with imageGenerator for thumbanil")
                }
               
            }*/
            print("had to print a black page")
            return nil
        }
    }
    
 
    
    func getPath(_ taskType: TaskType) -> String? {
        
        switch taskType {
        case .video:
            return NSHomeDirectory() + "/Documents/Videos/" + self.video!
        case .photo:
            return NSHomeDirectory() + "/Documents/Images/" + self.photo!
        case .audio:
            return NSHomeDirectory() + "/Documents/Audios/" + self.audio!
        case .text:
            print("there is no text path")
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
        
        if !self.disableText && self.text != nil {
           taskType.insert(.text)
        }
        return taskType
    }
    
 
    
    func ifFileExists(filePath: TaskType) -> Bool {
        
        
          var path: String!

        switch filePath {
            case .video:
            path = getPath(.video)!

            case .audio:
            path = getPath(.audio)!
            case .photo:
               path = getPath(.photo)!
        case .text:
            print("there is no file path for text - the text is just saved in a string")
            return false
        }
        return CoreDataManager.database.resourceExists(URLString: path)
    }

    func getAudio() -> URL {
        let URLString = getPath(.audio)!
        let url = URL(fileURLWithPath: URLString)
        return url
    }
    
    func getPhoto() -> UIImage {
        let URLString = getPath(.photo)!
        let photo = UIImage.init(contentsOfFile: URLString)
        return photo!
    }
    
    func getText() -> String {
        return self.text!
    }
    
    func getVideo() -> AVPlayer {
        let URLString = getPath(.video)!
        print(URLString)
        let url = URL(fileURLWithPath: URLString)
        let playerItem = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: playerItem)
        player.isMuted = true
        return player
    }
    
    
    func getTitles() -> String {
        return ""
    }
    
   func getAnalytics() -> String {
        var csvText: String = ""
        csvText += getTitles()
        for analytics in self.has?.array as! [Analytics] {
            csvText += analytics.getAnalytics()
            csvText += "\n"
         }
        return csvText
    }
    

    
    func getTaskTemplate() -> TaskTemplate? {
        var viewController: TaskTemplate?
        print("Task Description")
        print(self.getTaskType().description)
        let taskType = self.getTaskType()
        switch taskType {
       // There is no switch statement for nothing as it should envoke the default implementation
            
            // one
        case [.video]:
            viewController = self.getViewController(withIdentifier: "Video") as! Video
            print("selected video")
        case [.photo]:
            viewController = self.getViewController(withIdentifier: "Photo") as! Photo
            print("Selected Photo")
        case [.audio]:
            viewController = self.getViewController(withIdentifier: "Audio") as! Audio
            print("selected Audio")
        case [.text]:
            viewController = self.getViewController(withIdentifier: "Text") as! Text
            print("selected Text")
            
            
            
            //twos
        case [.text,.audio]:
            viewController = self.getViewController(withIdentifier: "AudioText") as! AudioText
            print("Selected AudioText")
        case [.video,.text]:
            viewController = self.getViewController(withIdentifier: "VideoText") as! VideoText
            print("Selected Video Text")
        case [.video,.audio]:
            viewController = self.getViewController(withIdentifier: "VideoAudio") as! VideoAudio
            print("Selected Video Audio")
        case [.audio,.photo]:
            viewController = self.getViewController(withIdentifier: "AudioPhoto") as! AudioPhoto
            print("Selected  Audio Photo")
        case [.photo,.text]:
            viewController = self.getViewController(withIdentifier: "PhotoText") as! PhotoText
            print("Selected photo text")
        case[.photo,.video]:
            viewController = self.getViewController(withIdentifier: "Video") as! Video
            print("Selected Photo and Video - not accessible")
            
            
 
            //threes
        case [.photo,.audio,.video]:
            print("Selected photo audio video - not accessible")
            viewController = self.getViewController(withIdentifier: "AudioPhoto") as! AudioPhoto
            print("Selected photo text")
            
        case [.photo,.text,.video]:
            viewController = self.getViewController(withIdentifier: "VideoText") as! VideoText
            print("Selecte photo text video - not accessible")
            
            
        case [.audio,.text,.photo]:
            viewController = self.getViewController(withIdentifier: "AudioTextPhoto") as! AudioTextPhoto
            print("Selected Audio Text Photo")
            
            
        case [.video,.audio,.text]:
            viewController = self.getViewController(withIdentifier: "VideoAudioText") as! VideoAudioText
            print("Selected Audio Video Text")
            
          
      
            // four
        case [.audio,.text,.photo,.video]:
            viewController = self.getViewController(withIdentifier: "VideoAudioText") as! VideoAudioText
            print("all 4")
            
        default:
            print("nothing was selected")
            print(taskType.description)
            return nil
      
        }
        
        if let vc = viewController {
            vc.setTask(task: self)
        }
        
        return viewController
        
    }
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}
