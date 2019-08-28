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
    @IBAction func editAction(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        // 移動先のvcをインスタンス化(ここの"Main"はStoryboardId。"Main"は起動時に設定されています。)
        let vc = storyboard.instantiateViewController(withIdentifier: "Edit")
        // 遷移処理
        self.present(vc, animated: true)
    }
    // 配信履歴ボタン
    @IBAction func logButton(_ sender:  UIButton) {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "movieLog", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "movieLog")
        // 遷移処理
        self.present(vc, animated: true)
    }
    // ログアウト
    @IBAction func LogoutAction(_ sender:  UIButton) {
        // ログアウト処理
        try! Auth.auth().signOut()
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Main")
        // 遷移処理
        self.present(vc, animated: true)
    }
    // ヘルプボタン
    @IBAction func helpButton(_ sender: UIButton) {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Help", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Help")
        // 遷移処理
        self.present(vc, animated: true)
    }
    // 個人情報ボタン
    @IBAction func dataButton(_ sender: UIButton) {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Data", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Data")
        // 遷移処理
        self.present(vc, animated: true)
    }
    // terms of serviceボタン
    @IBAction func tosButton(_ sender: UIButton) {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Tos", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Tos")
        // 遷移処理
        self.present(vc, animated: true)
    }
    // プライバシーボタン
    @IBAction func privacyButton(_ sender: UIButton) {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Privacy", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Privacy")
        // 遷移処理
        self.present(vc, animated: true)
    }
    
}
