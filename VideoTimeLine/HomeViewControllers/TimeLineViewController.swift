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

class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref: DatabaseReference!
    
    
    @IBOutlet weak var menuBar: UIView!
    

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: FloatingActionButton!
    
    // refreshControlインスタンス化
    let refreshControl = UIRefreshControl()
    var items = [NSDictionary]()
    
    
    
     // Firestoreのインスタンス化
     let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Xibとの接続
        tableView.register(UINib(nibName: "TimeLineTableViewCell", bundle: nil),forCellReuseIdentifier: "Cell")
        
        

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
        
        menuBar.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    
    @IBAction func menuTapped(_ sender: FloatingActionButton) {
        UIView.animate(withDuration: 0.3, animations: {
            
         if self.menuBar.transform == .identity {
            self.menuBar.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        } else {
            self.menuBar.transform = .identity
        }
    })
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
        return items.count
    }
    
    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimeLineCell", for: indexPath)
        
        
        return cell
    }
    
    
    
}
