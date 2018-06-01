//
//  VideoPlayer.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-31.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class PlayerView: UIView {
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
}
