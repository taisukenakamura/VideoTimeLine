//
//  FriendsViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/20.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import CoreLocation

class FriendsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchResults:[String] = []
   
    // 友達ストック
    var friendsList: [String] = ["Yusuke Ono","Taiga Shiga","Kichi Fukuzawa","Yuta Wanme","Shoutarou Tauchi","Makoto Horita","Masahiro Toyooka","Yu Nagai","Yusaku Kanada","Nana Hirata","Yui Yoshizawa","Yuriko Tsunokuni","kaori Kaizaki"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲート接続
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
    }
    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text != "" {
            return searchResults.count
        } else {
            
            return friendsList.count
        }
    }
    // セルに代入するもの
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsViewCell", for: indexPath)
        let friendName = cell.viewWithTag(2) as! UILabel
        if searchBar.text != "" {
            friendName.text = searchResults[indexPath.row]
        } else {
            
            friendName.text = friendsList[indexPath.row]
        }
        return cell
    }
    // セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Location", bundle: nil)
        let lvc: LocationViewController = storyboard.instantiateViewController(withIdentifier: "Location") as! LocationViewController
        let selectName = friendsList[indexPath.row]
        lvc.selectName = selectName
        self.present(lvc, animated: true)
        
    }
    // 検索ボタンが押された時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = true
        self.searchResults = friendsList.filter{
            // 大文字と小文字を区別せずに検索
            $0.lowercased().contains(searchBar.text!.lowercased())
        }
        self.tableView.reloadData()
    }
    // キャンセルボタンが押された時に呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        searchBar.text = ""
        self.tableView.reloadData()
    }
    // テキストフィールド入力開始前に呼ばれる
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }

    // ナビゲーションバーを消す
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
//    // 地図マップへ移動
//    @IBAction func locationButton(_ sender: UIButton) {
//
//
//    }
}

