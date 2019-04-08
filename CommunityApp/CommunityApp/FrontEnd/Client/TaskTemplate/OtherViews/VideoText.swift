//
//  VidTex.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
class VideoText: TaskTemplate {
    
    @IBOutlet weak var text: UILabel!
    
    @IBOutlet weak var playerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = super.task.getText()
        //playerView.playerLayer.videoGravity = .resizeAspect
        //playerView.playerLayer.needsDisplayOnBoundsChange = true
       // text.adjustsFontSizeToFitWidth = true
        
        playerView.player = super.task.getVideo()
        playerView.player?.play()
        self.navigationItem.title = "Video Text"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.playerView.playerLayer.frame = self.playerView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let player = playerView.player {
            player.play()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerView.player?.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
