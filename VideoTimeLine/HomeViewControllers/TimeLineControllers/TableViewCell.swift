//
//  TableViewCell.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/22.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import AVFoundation

class TableViewCell: UITableViewCell {
    
    var observers: (player: NSObjectProtocol,
    bounds: NSKeyValueObservation)?
    
    //動画を流すviewを宣言
    @IBOutlet weak var movieView: UIView!
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    // viewを流す
    func playVideo(_ forResource: String)  {
        
        // Bundle Resourcesからsample.mp4を読み込んで再生
        print("** arrayVideo:\(forResource)")
        let path = Bundle.main.path(forResource: forResource , ofType: "mp4")!
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        player.play()
        print(" ** path:\(path)")
        
        // AVPlayer用のLayerを生成
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = movieView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.zPosition = -2 // ボタン等よりも後ろに表示
        movieView.layer.insertSublayer(playerLayer, at: 0) // 動画をレイヤーとして追加
        
        // 動画の上に重ねる半透明の黒いレイヤー
        let dimOverlay = CALayer()
        dimOverlay.frame = movieView.bounds
        dimOverlay.backgroundColor = UIColor.black.cgColor
        dimOverlay.zPosition = -1
        dimOverlay.opacity = 0.3 // 不透明度
        movieView.layer.insertSublayer(dimOverlay, at: 0)
        
        // 最後まで再生したら最初から再生する
        let playerObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { [weak playerLayer] _ in
                playerLayer?.player?.seek(to: CMTime.zero)
                playerLayer?.player?.play()
        }
        
        
        // 端末が回転した時に動画レイヤーのサイズを調整する
        let boundsObserver = movieView.layer.observe(\.bounds) { [weak playerLayer, weak dimOverlay] view, _ in
            DispatchQueue.main.async {
                playerLayer?.frame = view.bounds
                dimOverlay?.frame = view.bounds
            }
        }
        
        observers = (playerObserver,boundsObserver)
        
    }
    deinit {
        // 画面が破棄された時に監視をやめる
        if let observers = observers {
            NotificationCenter.default.removeObserver(observers.player)
            
        }
        
    }
}
