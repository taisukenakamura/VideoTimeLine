//
//  TimeLineViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/20.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseFirestore
import NextLevel

class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate {
    
    var ref: DatabaseReference!
    
    
    @IBOutlet weak var menuBar: UIView!
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: FloatingActionButton!
    
    
    // mp4のresourceを配列で格納
    let resourceList: [String] = ["Owl - 18244", "588171196.615912"]
    // refreshControlインスタンス化
    let refreshControl = UIRefreshControl()
    var items = [NSDictionary]()

    // Firestoreのインスタンス化
    let db = Firestore.firestore()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // tableViewデリゲート接続
        tableView.delegate = self
        tableView.dataSource = self
        //テキストを追加
        refreshControl.attributedTitle = NSAttributedString(string: "更新中")
        // アクションを指定
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        // tableViewに追加
        tableView.addSubview(refreshControl)
        
        addButton.createFloatingActionButton()
        
        closeMenu()
    }
    
  
    // ＋ボタンを押した際の挙動
    @IBAction func menuTapped(_ sender: FloatingActionButton) {
        UIView.animate(withDuration: 0.3, animations: {
            
            if self.menuBar.transform == .identity {
                self.closeMenu()
            } else {
                self.menuBar.transform = .identity
            }
        })
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping:  0.3,initialSpringVelocity: 0,options: [], animations: {
            if self.menuBar.transform != .identity {
                self.pencilButton.transform = .identity
                self.videoButton.transform = .identity
                self.cameraButton.transform = .identity
            }
        })
    }
    // メニューバーを閉じる処理
    func closeMenu() {
        menuBar.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        pencilButton.transform = CGAffineTransform(translationX: 0, y: 15)
        videoButton.transform = CGAffineTransform(translationX: 11, y: 11)
        cameraButton.transform = CGAffineTransform(translationX: 15, y: 15)
    }
    
    // 更新
    @objc func refresh() {
        // 初期化
        items = [NSDictionary]()
        
        tableView.reloadData()
        // リフレッシュを止める
        refreshControl.endRefreshing()
    }
    
    // カメラ・フォトライブラリへの遷移処理
    func cameraAction(sourceType: UIImagePickerController.SourceType) {
        // カメラ・フォトライブラリが使用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            // インスタンス化
            let cameraPicker = UIImagePickerController()
            // ソースタイプの代入
            cameraPicker.sourceType = sourceType
            // デリゲートの接続
            cameraPicker.delegate = self
            // 画面遷移
            self.present(cameraPicker, animated: true)
            
        }
    }
    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourceList.count
    }
    
    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.playVideo(resourceList[indexPath.row])
    
        return cell
    }
    // セルの高さ設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
   
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("**willDisplay")
        indexPath.row
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        print("**didEndDisplaying")
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
    }
    // カメラを起動
    @IBAction func opneCamera(_ sender: Any) {
        cameraAction(sourceType: .camera)
    }
    // アルバムを起動
    @IBAction func openPhotos(_ sender: Any) {
        cameraAction(sourceType: .photoLibrary)
    }
    // プロフィール設定
    @IBAction func openProfile(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        // 移動先のvcをインスタンス化(ここの"Main"はStoryboardId。"Main"は起動時に設定されています。)
        let vc = storyboard.instantiateViewController(withIdentifier: "Edit")
        // 遷移処理
        self.present(vc, animated: true)
        
    }
    
  
}



