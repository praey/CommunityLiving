//
//  Task.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation


class Task: Codable {

    var title: String
    
    var isDisabled: Bool = false
    
    // This should point to the location of the File
    var photo: String? = nil
    var text: String? = nil
    var audio: String? = nil
    var video: String? = nil
    
    init(title: String, photo: String?) {
        self.title = title
        self.photo = photo
    }
    
    init(title: String, text: String?) {
        self.title = title
        self.text = text
        
    }
    
    init(title: String, audio: String?) {
        self.title = title
        self.audio = audio
    }
    
    init(title: String, video: String?) {
        self.title = title
        self.video = video
    }
    
    
    init(title: String, photo: String?, text: String?, audio: String?, video: String?) {
        self.title = title
        
        self.photo = photo
        self.text = text
        self.audio = audio
        self.video = video
    }
    
    func setDisabled() {
        isDisabled = !isDisabled
    }
 

    
}



