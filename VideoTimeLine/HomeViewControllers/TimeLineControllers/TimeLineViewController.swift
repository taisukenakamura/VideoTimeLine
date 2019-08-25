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


class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate {
    
   
    // ごみアニメーションの追加
    @IBOutlet weak var tableView: UITableView!
    
    // mp4のresourceを配列で格納
    let resourceList: [String] = ["Owl - 18244", "588411524.751567", "Owl - 18244", "Owl - 18244"]
    // refreshControlインスタンス化
    let refreshControl = UIRefreshControl()
    var items = [NSDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        // tableViewデリゲート接続
        tableView.delegate = self
        tableView.dataSource = self
        //テキストを追加
        refreshControl.attributedTitle = NSAttributedString(string: "更新中")
        // アクションを指定
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
    }
    
    // 更新
    @objc func refresh() {
        // 初期化
        items = [NSDictionary]()
        
        tableView.reloadData()
        // リフレッシュを止める
        refreshControl.endRefreshing()
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
        print("**willDisplay:\(indexPath.row)")
//        testIndexrow = indexPath.row
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        print("**didEndDisplaying")
        
    }
    // ナビゲーションバーを消す
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
    }
    
}



