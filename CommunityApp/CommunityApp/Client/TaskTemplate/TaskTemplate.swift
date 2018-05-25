//
//  TaskTemplate.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class TaskTemplate: UIViewController {
   
    
    var analyticData: AnalyticData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.analyticData = AnalyticData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveAnalytics()
    }
    
    

    
    private func saveAnalytics() {
        if let analytics = self.analyticData {
            // Save analytics to Core Data
            
        } else {
            print("There is no analytics to save")
        }
        
    }
    
    func getPhoto(photoLocation: String) {
        // This is where is gets it from the Database/FileSystem
    }
    
    func getText(textLocation: String) {
        // This is where is gets it from the Database/FileSystem
       // self.fileManager.urls(for: .documentDirectory, in: .userDomainMask)
       // self.fileManager.changeCurrentDirectoryPath(<#T##path: String##String#>)
    }
    
    func showAudio(audioLocation: String) {
        // This is where it get the audio
    }
    
    func showVideo(videoLocation: String) {
        // This is where it gets the video
    }

}

