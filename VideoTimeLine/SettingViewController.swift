//
//  SettingViewController.swift
//  
//
//  Created by 中村泰輔 on 2019/08/20.
//

import UIKit
import FirebaseAuth

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // 設定ボタン
    @IBAction func editAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        // 移動先のvcをインスタンス化(ここの"Main"はStoryboardId。"Main"は起動時に設定されています。)
        let vc = storyboard.instantiateViewController(withIdentifier: "Edit")
        // 遷移処理
        self.present(vc, animated: true)
    }
    // ログアウト
    @IBAction func LogoutAction(_ sender: Any) {
        
        // ログアウト処理
        try! Auth.auth().signOut()
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Main")
        // 遷移処理
        self.present(vc, animated: true)
    }
}
