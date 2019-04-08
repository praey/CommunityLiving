//
//  FileSystemManager.swift
//  CoreDataNewTry
//
//  Created by Tianyuan Zhang on 2018/5/12.
//  Copyright © 2018年 qwe. All rights reserved.
//

import Foundation
import UIKit

class FileSystemManager{
    
    static let fileSystemManager = FileSystemManager()
    lazy var fileManager = FileManager.default
    let filePath: String = NSHomeDirectory() + "/Documents/"
    
    func checkFolderExistence(type: String) -> (Bool){
        let path = filePath + type
        let exist = fileManager.fileExists(atPath: path)
        return exist
    }
    
    func createFolder(type: String){
        if !checkFolderExistence(type: type) {
            do {
                try fileManager.createDirectory(atPath: filePath + type, withIntermediateDirectories: true, attributes: nil)
                print("\(type) folder is created!")
                return
            }
            catch let error as NSError{
                NSLog("Creation failed: \(error.debugDescription)")
            }
        }
        print("\(type) folder is detected!")
    }
    
    func createImageFolder(){
        createFolder(type: "Images")
    }
    
    func createVideoFolder(){
        createFolder(type: "Videos")
    }
    
    func createAudioFolder(){
        createFolder(type: "Audios")
    }
    
    func saveImage(task: Task, image: UIImage, quality: CGFloat, nameWithExtension: String){
        if let imageRep = UIImageJPEGRepresentation(image, quality) as NSData?{
            let imageURLString = filePath + "Images/\(nameWithExtension)"
            imageRep.write(toFile: imageURLString, atomically: true)
            print("Image is saved!")
            print(imageURLString)
        }
    }
    
    func getImage(task: Task) -> (UIImage){
        print("Image name: ")
        print(task.photo!)
        let image = UIImage(contentsOfFile: NSHomeDirectory() + "/Documents/Images/" + task.photo!)
        return image!
    }
    
    func deletImage(URLString: String){
        do{
            try fileManager.removeItem(atPath: URLString)
            print("Image is removed!")
        }
        catch let error as NSError{
            print("error")
            print(error.localizedDescription)
        }
    }
    
    func saveVideo(task: Task, videoFromURLString: String, nameWithExtension: String){
        if let urlData = NSData(contentsOfFile: videoFromURLString){
            let videoURLString = filePath + "Videos/\(nameWithExtension)"
            urlData.write(toFile: videoURLString, atomically: true)
            print("Video is saved!")
        }
    }
    
    func getVideo(task: Task) -> (String){
        return NSHomeDirectory() + "/Documents/Videos/\(task.video!)"
    }
    
    func deletVideo(URLString: String){
        do{
            try fileManager.removeItem(atPath: URLString)
            print("Video is removed!")
        }
        catch let error as NSError{
            print("error")
            print(error.localizedDescription)
        }
    }
    
    func saveAudio(task: Task, audioFromURLString: String, nameWithExtension: String){
        if let urlData = NSData(contentsOfFile: audioFromURLString){
            let audioURLString = filePath + "Audios/\(nameWithExtension)"
            urlData.write(toFile: audioURLString, atomically: true)
            print("Audio is saved!")
        }
    }
    
    func getAudio(task: Task) -> (String){
        return NSHomeDirectory() + "/Documents/Audios/\(task.audio!)"
    }
    
    func deletAudio(URLString: String){
        do{
            try fileManager.removeItem(atPath: URLString)
            print("Audio is removed!")
        }
        catch let error as NSError{
            print("error")
            print(error.localizedDescription)
        }
    }
}
