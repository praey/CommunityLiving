//
//  Vid.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class Video: TaskTemplate {
    @IBOutlet weak var playerView: PlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.player = super.task.getVideo()
        playerView.player?.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
