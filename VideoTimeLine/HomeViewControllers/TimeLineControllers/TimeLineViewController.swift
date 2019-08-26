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
    
    // tableViewの接続
    @IBOutlet weak var tableView: UITableView!
    // mp4のresourceを配列で格納
    let resourceList: [String] = ["Owl - 18244", "588411524.751567", "Owl - 18244", "Owl - 18244"]
    // refreshControlインスタンス化
    let refreshControl = UIRefreshControl()
    
    var detailViewController = DetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableViewデリゲート接続
        tableView.delegate = self
        tableView.dataSource = self
        // UILongPressGestureRecognizer宣言 デリゲート接続
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        longPressGesture.delegate = self
        //テキストを追加
        refreshControl.attributedTitle = NSAttributedString(string: "更新中")
        // アクションを指定
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        // tableViewにrecognizerを設定
        tableView.addGestureRecognizer(longPressGesture)
    }
    // 更新
    @objc func refresh() {

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
        // セルにビデオを流す
        cell.playVideo(resourceList[indexPath.row])
        
        return cell
    }
    // セルの高さ設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    // 長押しした際に呼ばれるメソッド
    @objc func longPress(_ recognizer: UILongPressGestureRecognizer) {
        print("*****************")
        // 押された位置でcellのPathを取得
        let point = recognizer.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        if recognizer.state == UIGestureRecognizer.State.began {
             // 長押しされた場合の処理
            print("長押しされたcellのindexPath:\(indexPath?.row)")
            view.addSubview(detailViewController.view)
            
        } else if recognizer.state == UIGestureRecognizer.State.ended  {
            
        }
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
