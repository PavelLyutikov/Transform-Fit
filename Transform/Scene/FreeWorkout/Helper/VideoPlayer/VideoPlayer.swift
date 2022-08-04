//
//  VideoPlayer.swift
//  AVPlayer
//
//  Created by mac on 16.08.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import AVKit
import SnapKit
import AVFoundation
import CachingPlayerItem

class VideoPlayer: UIView {

    var pauseIsActive: Bool = false
    
    let isOpenHomeWorkout = UserDefaults.standard.bool(forKey: "isOpenHomeWorkout")
    let isOpenYoga = UserDefaults.standard.bool(forKey: "isOpenYoga")
    let isOpenRecovery = UserDefaults.standard.bool(forKey: "isOpenRecovery")
    
    let totalSize = UIScreen.main.bounds.size

    @IBOutlet weak var vwPlayer: UIView!

    var player: AVPlayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    fileprivate func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("VideoPlayer", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        addPlayerToView(self.vwPlayer)
        
        print("тварь5")
    }

    fileprivate func addPlayerToView(_ view: UIView) {
        player = AVPlayer()

        let wdth: CGFloat!
        let hght: CGFloat!
        let positX: CGFloat!
        let positY: CGFloat!
        if totalSize.height >= 920 {
            if isOpenHomeWorkout == true {
                wdth = 660
                hght = 660
                positX = 520
                positY = 870
            } else if isOpenYoga == true {
                wdth = 850
                hght = 850
                positX = 620
                positY = 970
            } else if isOpenRecovery == true {
                wdth = 400
                hght = 400
                positX = 405
                positY = 860
            } else {
                wdth = 760
                hght = 760
                positX = 580
                positY = 940
            }
        } else if totalSize.height >= 890 && totalSize.height <= 919 {
            if isOpenYoga == true {
                wdth = 760
                hght = 760
                positX = 600
                positY = 940
            } else if isOpenHomeWorkout == true {
                wdth = 640
                hght = 640
                positX = 550
                positY = 920
            } else if isOpenRecovery == true {
                wdth = 350
                hght = 350
                positX = 405
                positY = 860
            } else {
                wdth = 760
                hght = 760
                positX = 600
                positY = 950
            }
        } else if totalSize.height >= 830 && totalSize.height <= 889 {
            if isOpenHomeWorkout == true {
                wdth = 600
                hght = 600
                positX = 530
                positY = 890
            } else if isOpenYoga == true {
                wdth = 730
                hght = 730
                positX = 590
                positY = 920
            } else if isOpenRecovery == true {
                wdth = 350
                hght = 350
                positX = 405
                positY = 860
            }else {
                wdth = 730
                hght = 730
                positX = 590
                positY = 960
            }
        } else if totalSize.height == 812 {
            if isOpenYoga == true {
                wdth = 720
                hght = 720
                positX = 585
                positY = 960
            } else if isOpenHomeWorkout == true {
                wdth = 600
                hght = 600
                positX = 525
                positY = 915
            } else if isOpenRecovery == true {
                wdth = 320
                hght = 320
                positX = 380
                positY = 840
            } else {
                wdth = 670
                hght = 670
                positX = 560
                positY = 950
            }
        } else if totalSize.height >= 671 && totalSize.height <= 800 {
            if isOpenHomeWorkout == true {
                wdth = 620
                hght = 620
                positX = 500
                positY = 660
            } else if isOpenYoga == true {
                wdth = 700
                hght = 700
                positX = 560
                positY = 750
            } else if isOpenRecovery == true {
                wdth = 320
                hght = 320
                positX = 380
                positY = 650
            } else {
                wdth = 700
                hght = 700
                positX = 560
                positY = 760
            }
        } else if totalSize.height <= 670 {
            if isOpenHomeWorkout == true {
                wdth = 560
                hght = 560
                positX = 485
                positY = 640
            } else if isOpenYoga == true {
                wdth = 640
                hght = 640
                positX = 550
                positY = 760
            } else if isOpenRecovery == true {
                wdth = 300
                hght = 300
                positX = 390
                positY = 670
            } else {
                wdth = 640
                hght = 640
                positX = 555
                positY = 785
            }
        } else {
            if isOpenHomeWorkout == true {
                wdth = 850
                hght = 850
                positX = 640
                positY = 1000
            } else if isOpenYoga == true {
                wdth = 770
                hght = 770
                positX = 600
                positY = 1000
            } else if isOpenRecovery == true {
                wdth = 320
                hght = 320
                positX = 380
                positY = 840
            } else {
                wdth = 770
                hght = 770
                positX = 600
                positY = 1000
            }
            
        }

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
        playerLayer.videoGravity = .resizeAspect
        playerLayer.zPosition = 1
        playerLayer.frame = CGRect(x: view.bounds.width - positX, y: view.bounds.height - positY, width: wdth, height: hght)
        view.layer.addSublayer(playerLayer)
     
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: nil) { (_) in
            self.player?.seek(to: CMTime.zero)
            self.player?.play()
        }

    }

    func playVideoWithData(data: Data) {
        guard var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        url.appendPathComponent("video.mp4")
        try? data.write(to: url)
        
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        try? AVAudioSession.sharedInstance().setActive(true)

        let playerItem = CachingPlayerItem(url: url)
        playerItem.delegate = self
        player?.replaceCurrentItem(with: playerItem)
        player?.automaticallyWaitsToMinimizeStalling = false
        player?.play()
    }

    @objc func playerEndPlay() {
        if let play = player {
            print("stopped")
            play.pause()
            player = nil
            print("player deallocated")
        } else {
            print("player was already deallocated")
        }
    }
    @objc func playerPause() {
        if let play = player {
            print("playPause")
            play.pause()
            pauseIsActive = true
        } else {
            print("player was already deallocated")
        }
    }
    @objc func playerPlay() {
        if let play = player {
            print("playPlayer")
            play.play()
        pauseIsActive = false
        } else {
            print("player was already deallocated")
        }
    }
}

extension VideoPlayer: CachingPlayerItemDelegate {
    
    func playerItemReadyToPlay(_ playerItem: CachingPlayerItem) {
        
        if isOpenYoga == true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "videoReady"), object: nil)
        } else if isOpenHomeWorkout == true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "videoReadyWorkout"), object: nil)
        } else if isOpenRecovery == true {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "videoReadyPostPregnancyRecovery"), object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "videoReadyStretching"), object: nil)
        }
        
        print("Video ready.")
    }
    
    private func playerItem(_ playerItem: CachingPlayerItem, didFinishDownloadingData data: Data) {
        print("File is downloaded and ready for storing")
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, didDownloadBytesSoFar bytesDownloaded: Int, outOf bytesExpected: Int) {
        print("\(bytesDownloaded)/\(bytesExpected)")
    }
    
    func playerItemPlaybackStalled(_ playerItem: CachingPlayerItem) {
        print("Not enough data for playback. Probably because of the poor network. Wait a bit and try to play later.")
    }
    
    func playerItem(_ playerItem: CachingPlayerItem, downloadingFailedWith error: Error) {
        print(error)
    }
    
    func playerItemDidFailToPlay(_ playerItem: CachingPlayerItem, withError error: Error?) {
        print("ErrorVideo")
    }
    
    
}
