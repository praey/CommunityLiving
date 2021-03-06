//
//  VidAud.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
class VideoAudio: TaskTemplate {
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var playerView: PlayerView!

    
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
        self.navigationItem.title = "Video Audio"
        
        playerView.player = super.task.getVideo()
        playerView.player?.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let audioPlayer = audioPlayer {
            audioPlayer.play()
        }
        if let player = playerView.player {
            player.play()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let audioPlayer = audioPlayer {
            audioPlayer.pause()
        }
          playerView.player?.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
