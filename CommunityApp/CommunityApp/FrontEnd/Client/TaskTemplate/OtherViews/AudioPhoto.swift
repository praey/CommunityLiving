//
//  AudPho.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
class AudioPhoto: TaskTemplate {
    var audioPlayer: AVAudioPlayer?
    
    
    @IBOutlet weak var image: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
         image.image = super.task.getPhoto()
        do {
            let url = super.task.getAudio()
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            if let audioPlayer = audioPlayer {
                audioPlayer.play()
            }
        } catch {
            print("There is no audioplayer to play")
        }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
