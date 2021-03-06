//
//  Aud.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

import AVFoundation
class Audio: TaskTemplate {
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let url = super.task.getAudio()
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            if let audioPlayer = audioPlayer {
                audioPlayer.play()
            }
        } catch {
            print("There is no audioplayer to play")
        }
        self.navigationItem.title = "Audio"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let audioPlayer = audioPlayer {
            audioPlayer.play()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         if let audioPlayer = audioPlayer {
            audioPlayer.pause()
        }
    }

}
