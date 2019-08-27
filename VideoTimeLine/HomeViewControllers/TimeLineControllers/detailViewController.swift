//
//  DetailViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/26.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    // 初期値
    var selectedVideo: String = ""
    // 映像を流す
    @IBOutlet weak var movieView: UIView!
    
    var observers: (player: NSObjectProtocol,
    bounds: NSKeyValueObservation)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 再生
        playVideo(selectedVideo)
        // 背景色
        self.view.backgroundColor = UIColor(
            red: 150/255,
            green: 150/255,
            blue: 150/255,
            alpha: 0.6
        )
    }
    
    // どこかタップされたときポップアップを消し去る関数
    @objc func tapped(_ sender: UITapGestureRecognizer){
        self.view.removeFromSuperview()
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
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
        
        // 最後まで再生したら最初から再生する
        let playerObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { [weak playerLayer] _ in
                playerLayer?.player?.seek(to: CMTime.zero)
                playerLayer?.player?.play()
        }
        
        // 端末が回転した時に動画レイヤーのサイズを調整する
        let boundsObserver = movieView.layer.observe(\.bounds) { [weak playerLayer] view, _ in
            DispatchQueue.main.async {
                playerLayer?.frame = view.bounds
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
