//
//  MoviePlayerView.swift
//  VideoRecorder
//
//  Created by Christian Lorenzo on 5/11/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

class MoviePlayerView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    var videoPlayerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    var player: AVPlayer? {
        get { return videoPlayerLayer.player }
        set { videoPlayerLayer.player = newValue }
    }
}
