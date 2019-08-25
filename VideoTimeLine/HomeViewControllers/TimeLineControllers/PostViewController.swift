//
//  PostViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/21.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import FirebaseFirestore

class PostViewController: UIViewController {
    
    // firestoreのインスタンス化
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // キーボードを消す処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
}
