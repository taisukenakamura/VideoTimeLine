//
//  ViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/19.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseUI

class ViewController: UIViewController, FUIAuthDelegate {
    // ログイン認証ボタン
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var AuthButton: UIButton!
    // Google、電話番号認証
    var authUI: FUIAuth { get { return FUIAuth.defaultAuthUI()!}}
    // 認証に利用するプロバイダの選択
    let providers: [FUIAuthProvider] = [
        FUIGoogleAuth(),
        FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!)
    ]
    
    private var observers: (player: NSObjectProtocol,bounds: NSKeyValueObservation)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲートとの接続
        self.authUI.delegate = self
        self.authUI.providers = providers
        AuthButton.addTarget(self,action: #selector(self.AuthButtonTapped(sender:)),for: .touchUpInside)
        // 動画再生　＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
        // Bundle Resourcesからsample.mp4を読み込んで再生
        let path = Bundle.main.path(forResource: "Owl - 18244", ofType: "mp4")!
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        player.play()
        
        // AVPlayer用のLayerを生成
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.zPosition = -2 // ボタン等よりも後ろに表示
        view.layer.insertSublayer(playerLayer, at: 0) // 動画をレイヤーとして追加
        
        // 動画の上に重ねる半透明の黒いレイヤー
        let dimOverlay = CALayer()
        dimOverlay.frame = view.bounds
        dimOverlay.backgroundColor = UIColor.black.cgColor
        dimOverlay.zPosition = -1
        dimOverlay.opacity = 0.1 // 不透明度
        view.layer.insertSublayer(dimOverlay, at: 0)
        
        // 最後まで再生したら最初から再生する
        let playerObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { [weak playerLayer] _ in
                playerLayer?.player?.seek(to: CMTime.zero)
                playerLayer?.player?.play()
                
        }
        // 端末が回転した時に動画レイヤーのサイズを調整する
        let boundsObserver = view.layer.observe(\.bounds) { [weak playerLayer, weak dimOverlay] view, _ in
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
            observers.bounds.invalidate()
        }
    // =======================================================================================
}
    // ボタンをタップした際の挙動
    @objc func AuthButtonTapped(sender : AnyObject) {
        // FirebaseUIのViewの取得
        let authViewController = self.authUI.authViewController()
        // FirebaseUIのViewの表示
        self.present(authViewController, animated: true, completion: nil)
    }
    
    //　認証画面から離れたときに呼ばれる（キャンセルボタン押下含む）
    public func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?){
        // 認証に成功した場合
        if error == nil {
            // storyboardのfileの特定
            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            // 移動先のvcをインスタンス化
            let htbc: HomeTabBarController = storyboard.instantiateViewController(withIdentifier: "Home") as! HomeTabBarController
            // 遷移処理
            self.present(htbc, animated: true)
        }
        // エラー時の処理をここに書く
        return
    }
    
    // Signin
    @IBAction func tappedSignUp(_ sender: UIButton) {
        // signup画面へ
        let storyboard: UIStoryboard = UIStoryboard(name: "Signup", bundle: nil)
        let svc: SignUpViewController = storyboard.instantiateViewController(withIdentifier: "Signup") as! SignUpViewController
        self.present(svc, animated: true)
        
    }
    // Login
    @IBAction func tappedLogIn(_ sender: UIButton) {
        // ログイン画面へ
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let lvc: LoginViewController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        self.present(lvc, animated: true)
    }
    
}







