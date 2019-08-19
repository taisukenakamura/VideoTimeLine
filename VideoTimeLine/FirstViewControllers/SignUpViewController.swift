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

    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       textFieldColor()
        
        
    }
    
    func textFieldColor() {
        
        emailTextField.placeholderColor = .darkGray
        emailTextField.borderActiveColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        emailTextField.borderInactiveColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        passwordTextField.placeholderColor = .darkGray
        passwordTextField.borderActiveColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        passwordTextField.borderInactiveColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        
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
                
            }
        })
    }
    
    // エラーが帰ってきた場合のアラート
    func showErrorAlert(error: Error?) {
        
        let alert = UIAlertController(title: "エラー", message: error?.localizedDescription, preferredStyle: .alert)
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

