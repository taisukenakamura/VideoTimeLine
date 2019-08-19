//
//  ViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/19.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bundle Resourcesからsample.mp4を読み込んで再生
        let path = Bundle.main.path(forResource: "Owl - 18244", ofType: "mp4")!
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        player.play()
        
        // AVPlayer用のLayerを生成
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.zPosition = -1 // ボタン等よりも後ろに表示
        view.layer.insertSublayer(playerLayer, at: 0) // 動画をレイヤーとして追加
        
        // 動画の上に重ねる半透明の黒いレイヤー
        let dimOverlay = CALayer()
        dimOverlay.frame = view.bounds
        dimOverlay.backgroundColor = UIColor.black.cgColor
        dimOverlay.zPosition = -1
        dimOverlay.opacity = 0.6 // 不透明度
        view.layer.insertSublayer(dimOverlay, at: 0)

    }
    
    @IBAction func tappedSignUp(_ sender: UIButton) {
        
//        sender.flash()
        let storyboard: UIStoryboard = UIStoryboard(name: "Signup", bundle: nil)
        let svc: SignUpViewController = storyboard.instantiateViewController(withIdentifier: "Signup") as! SignUpViewController
         self.present(svc, animated: true)
        
    }
    
    @IBAction func tappedLogIn(_ sender: UIButton) {
        
//         signupButton.flash()
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let lvc: LoginViewController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        
//        flash()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            // your code here
            self.present(lvc, animated: true)
//        }
    }
    
    func flash () {
        
        UIView.animate(withDuration: 0.1
            , delay: 0
            , options: [.repeat,.autoreverse]
            , animations: {
                self.loginButton.alpha = 0
        })
        
        
    }
    
    
    
}


