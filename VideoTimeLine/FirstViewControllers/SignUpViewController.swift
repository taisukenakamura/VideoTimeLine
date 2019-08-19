//
//  SignupViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/19.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import FirebaseAuth
import TextFieldEffects

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: YokoTextField!
    @IBOutlet weak var passwordTextField: YokoTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       textFieldColor()
        
        
    }
    
    func textFieldColor() {
        
        emailTextField.placeholderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.foregroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        passwordTextField.placeholderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.foregroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
    }
    // ユーザー新規作成
    @IBAction func createUser(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
            // エラー時の処理
            if let error = error {
                 self.showErrorAlert(error: error)
                // 成功時の処理
            } else {
                
                sender.flash()
                self.toTimeLine()
            }
        })
    }
    
    
    // タイムラインへ遷移
    func toTimeLine() {
        // storyboardのfileの特定
        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        // 移動先のvcをインスタンス化
        let vc = storyboard.instantiateViewController(withIdentifier: "Home")
        // 遷移処理
        self.present(vc, animated: true)
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

