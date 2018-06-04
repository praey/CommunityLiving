//
//  Vid.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
class Video: TaskTemplate {
    @IBOutlet weak var playerView: PlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.player = super.task.getVideo()
        playerView.player?.play()
        
        
        
//        let player = super.task.getVideo()
//        let avLayer = AVPlayerLayer.init(player: player)
//        avLayer.frame = playerView.frame
//        playerView.layer.addSublayer(avLayer)
//        // player.play()
//        (playerView.layer as! AVPlayerLayer).player?.play()
//        
//        let avPlayerLayer = AVPlayerLayer.init(player: player)
//        avPlayerLayer.frame = self.view.frame
//        self.view.layer.addSublayer(avPlayerLayer)
//        player.play()
//
        // playerView.frame = self.view.frame
        // self.view.addSubview(playerView!)
        
    }
    
    @IBAction func playVideo(_ sender: Any) {
        // playerView.player?.play()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
