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
        
        guard self.disableTask == true else {
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
        
        if let analytics = self.analytics {
            csvText += analytics.getAnalytics()
        }
        
        // for analytics in self.analytics {
        //    csvText += analytics.getAnalytics()
        // }
    
        return csvText        
    }
    
    func startAnalytics() {
        // var array: [Analytics] = []
        //analytic = Analytics()
        
        //array.append(<#T##newElement: Analytics##Analytics#>)
        //self.analytics.add
    }
    func saveAnalytics() {
        
       // CoreDataManager.database.saveAnalytics(task: self, date: Date().n, duration: <#T##TimeInterval#>)
        
    }
    
    func getTaskTemplate() -> TaskTemplate? {
        var viewController: TaskTemplate?
        let taskType = self.getTaskType()
        switch taskType {
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
        case [.text,.audio]:
            viewController = self.getViewController(withIdentifier: "AudioText") as! AudioText
            print("Selected AudioText")
        case [.video,.audio,.text]:
            viewController = self.getViewController(withIdentifier: "VideoAudioText") as! VideoAudioText
            print("Selected Audio Video Text")
        case [.audio,.text,.photo]:
            viewController = self.getViewController(withIdentifier: "AudioTextPhoto") as! AudioTextPhoto
            print("Selected Audio Text Photo")
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
            print("Selected Photo and Video - not accessible")
        case [.photo,.audio,.video]:
            print("Selected photo audio video - not accessible")
        case [.photo,.text,.video]:
            print("Selecte photo text video - not accessible")
        default :
            print(taskType.description)
            print("failed to select type")
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
