//
//  EditViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/22.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import FirebaseAuth

class EditViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: CircleImageView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var phraseTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProfile()
    }
    
    // ローカルで持っているprofile情報を反映
    func getProfile() {
        // 画像情報から
        if let profImage = UserDefaults.standard.object(forKey: "profileImage") {
            // NSData型に変換
            let dataImage = NSData(base64Encoded: profImage as! String, options: .ignoreUnknownCharacters)
            // さらにUIImage型に変換
            let decodedImage = UIImage(data: dataImage! as Data)
            // profileImageViewに代入
            profileImageView.image = decodedImage
        } else {
            // なければアイコン画像を入れておく
            profileImageView.image = #imageLiteral(resourceName: "人物アイコン (1)")
        }
        // 名前情報
        if let profName = UserDefaults.standard.object(forKey: "userName") as? String {
            // userNameTextFieldへ代入
            userNameTextField.text = profName
        } else {
            // なければ匿名としておく
            userNameTextField.text = "匿名"
        }
        
        // 名前情報
        if let yourPhrase = UserDefaults.standard.object(forKey: "phrase") as? String {
            // userNameTextFieldへ代入
            phraseTextField.text = yourPhrase
        } else {
            // なければ匿名としておく
            phraseTextField.text = ""
        }
    }
    
    @IBAction func changeProPhoto(_ sender: Any) {
        
        // アクションシートを定義
        let alert = UIAlertController(title: "選択してください", message: nil, preferredStyle: .actionSheet)
        // カメラ機能
        let openCamera = UIAlertAction(title: "カメラ", style: .default, handler: {(action: UIAlertAction!) in
            // ここに実際にカメラへの遷移処理を書く
            self.cameraAction(sourceType: .camera)
        })
        // アルバム
        let openPhotos = UIAlertAction(title: "アルバム", style: .default, handler: {(action: UIAlertAction!) in
            // ここに実際のアルバムへの遷移処理を書く
            self.cameraAction(sourceType: .photoLibrary)
        })
        // キャンセル
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        // アラートの追加
        alert.addAction(openCamera)
        alert.addAction(openPhotos)
        alert.addAction(cancelAction)
        // 表示
        present(alert, animated: true)
    }
    // カメラ・フォトライブラリへの遷移処理
    func cameraAction(sourceType: UIImagePickerController.SourceType) {
        // カメラ・フォトライブラリが使用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            // インスタンス化
            let cameraPicker = UIImagePickerController()
            // ソースタイプの代入
            cameraPicker.sourceType = sourceType
            // デリゲートの接続
            cameraPicker.delegate = self
            // 画面遷移
            self.present(cameraPicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //
        if let pickedImage = info[.originalImage] as? UIImage {
            // 画面サイズに合わせて
            profileImageView.contentMode = .scaleToFill
            // ①プロフ画像に反映
            profileImageView.image = pickedImage
        }
        // ②pickerは閉じる
        picker.dismiss(animated: true)
    }
    // セーブ
    @IBAction func changeButton(_ sender: Any) {
        
        var data: NSData = NSData()
        // imageの存在確認
        if let image = profileImageView.image {
            // クオリティを10パーセントに下げる
            data = image.jpegData(compressionQuality: 0.1)! as NSData
        }
        let base64String = data.base64EncodedString(options: .lineLength64Characters) as String
        
        let userName = userNameTextField.text
        
        let phrase = phraseTextField.text
        // アプリ内に保存
        // プロフ画像の保存
        UserDefaults.standard.set(base64String, forKey: "profileImage")
        // ユーザー名の保存
        UserDefaults.standard.set(userName, forKey: "userName")
        // ひとことの保存
        UserDefaults.standard.set(phrase, forKey: "phrase")
        // 遷移
        dismiss(animated: true)
    }
    
    // キーボードを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if userNameTextField.isFirstResponder {
            userNameTextField.resignFirstResponder()
        }
        if phraseTextField.isFirstResponder {
            phraseTextField.resignFirstResponder()
        }
    }
}
