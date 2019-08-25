//
//  FirstScreenViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/19.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import FirebaseAuth
import TextFieldEffects

class LoginViewController: UIViewController {

    // メール入力欄
    @IBOutlet weak var emailTextField: YokoTextField!
    // パスワード入力欄
    @IBOutlet weak var passwordTextField: YokoTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // ログイン
    @IBAction func userLogin(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        // FirebaseAuthのログイン処理
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print("ログイン失敗")
                // エラーアラートの表示
                self.showErrorAlert(error: error)
            } else {
                // 認証成功
                
                print("ログイン成功")
                self.toTimeLine()
            }
        })
        
    }
    
    // タイムラインへ遷移
    func toTimeLine() {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        // 移動先のvcをインスタンス化
        let htbc: HomeTabBarController = storyboard.instantiateViewController(withIdentifier: "Home") as! HomeTabBarController
        // 遷移処理
        self.present(htbc, animated: true)
    }
    
    // エラーが帰ってきた場合のアラート
    func showErrorAlert(error: Error?) {
        
        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okAction)
        // 表示
        self.present(alert, animated: true)
    }
    // キーボードを閉じる処理
    // タッチされたかを判断
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // キーボードが開いていたら
        if (emailTextField.isFirstResponder) {
            // 閉じる
            emailTextField.resignFirstResponder()
        }
        if (passwordTextField.isFirstResponder) {
            passwordTextField.resignFirstResponder()
        }
    }
    
}
