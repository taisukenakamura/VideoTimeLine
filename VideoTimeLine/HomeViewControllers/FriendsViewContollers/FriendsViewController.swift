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
    // tableViewと接続
    @IBOutlet weak var tableView: UITableView!
    // searchbar
    @IBOutlet weak var searchBar: UISearchBar!
    // 検索結果
    var searchResults:[String] = []
    // 友達ストック
    var friendsList: [String] = ["Yusuke Ono","Taiga Shiga","Kichi Fukuzawa","Yuta Wanme","Shoutarou Tauchi","Makoto Horita","Masahiro Toyooka","Yu Nagai","Yusaku Kanada","Nana Hirata","Yui Yoshizawa","Yuriko Tsunokuni","kaori Kaizaki"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // デリゲート接続
        tableView.delegate = self
        tableView.dataSource = self
        // デリゲート接続
        searchBar.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    // セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text != "" {
            // 検索結果
            return searchResults.count
        } else {
            // 友達リスト
            return friendsList.count
        }
    }
    // セルに代入するもの
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsViewCell", for: indexPath)
        // アイコン画像のレイアウト
        let imgIcon = cell.viewWithTag(1) as! UIImageView
        imgIcon.layer.masksToBounds = false
        imgIcon.layer.shadowColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imgIcon.layer.shadowOffset = CGSize(width: 6, height: 2)
        imgIcon.layer.shadowRadius = 2
        imgIcon.layer.shadowOpacity = 0.8
        // セルをタップした際の色
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
    
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
    // セルタップ時
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
    // トークルームへ
    @IBAction func talkButton(_ sender: Any) {
        
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "TalkRoom", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "TalkRoom")
        // 遷移処理
        self.present(vc, animated: true)
        
    }
}

