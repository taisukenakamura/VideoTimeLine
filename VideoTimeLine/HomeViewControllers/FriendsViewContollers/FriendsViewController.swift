//
//  FriendsViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/20.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import CoreLocation

class FriendsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    // 友達ストック
    var friendsList: [String] = ["佐藤","中村","加藤","鈴木","伊藤","高橋","小野","田中","山本",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲート接続
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    // セルに代入するもの
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsViewCell", for: indexPath)
        
        let friendName = cell.viewWithTag(2) as! UILabel
        friendName.text = friendsList[indexPath.row]
        
        
        return cell
    }
    // セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
        
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    // ナビゲーションバーを消す
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    // 地図マップへ移動
    @IBAction func locationButton(_ sender: UIButton) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Location", bundle: nil)
        let lvc: LocationViewController = storyboard.instantiateViewController(withIdentifier: "Location") as! LocationViewController
        self.present(lvc, animated: true)
        
    }
}
