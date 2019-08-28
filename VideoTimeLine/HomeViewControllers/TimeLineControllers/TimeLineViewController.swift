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


class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate {
    
    var observers: (player: NSObjectProtocol,
    bounds: NSKeyValueObservation)?
    
    // tableViewの接続
    @IBOutlet weak var tableView: UITableView!
    // mp4のresourceを配列で格納
    let resourceList: [String] = ["Owl - 18244","588411524.751567","マイムービー","makoto"]
    // refreshControlインスタンス化
    let refreshControl = UIRefreshControl()

   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableViewデリゲート接続
        tableView.delegate = self
        tableView.dataSource = self
        
        //ロングプレス
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(TimeLineViewController.longPress(_:)))
        
        longPressGesture.delegate = self
        //Viewに追加
        self.view.addGestureRecognizer(longPressGesture)
        
        //テキストを追加
        refreshControl.attributedTitle = NSAttributedString(string: "更新中")
        // アクションを指定
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
    // 更新
    @objc func refresh() {
        
        tableView.reloadData()
        // リフレッシュを止める
        refreshControl.endRefreshing()
    }
    
    // セルの設定 ========================================================================
    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourceList.count
    }
    
    // セルの設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        // セルにビデオを流す
        cell.playVideo(resourceList[indexPath.row],true)
        
        
        return cell
    }
    // セルの高さ設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
    // =========================================================================
    //longpressイベント
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        
        print("*****************")
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        let vc: DetailViewController = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
       
        //送信者の状態が　タッチ開始時にlongが認識される
        if sender.state == .began{
            //開始は認知される
            print("Long Press began")
            // 押された位置でcellのPathを取得
            let point = sender.location(in: tableView)
            var indexPath = tableView.indexPathForRow(at: point)
            let selectedVideo = resourceList[(indexPath?.row)!]
            let selectedNumber = indexPath?.row
            print("長押しされたcellのindexPath:\(String(describing: indexPath?.row))")

            vc.selectedVideo = selectedVideo
            vc.selectedNumber = selectedNumber!
            present(vc, animated: true)
        }
        else if sender.state == .ended {
        
        }
    }
    
   
    
    
    
}


