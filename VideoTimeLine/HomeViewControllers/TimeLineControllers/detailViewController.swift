//
//  DetailViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/26.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenWidth:CGFloat = self.view.frame.width
        let screenHeight:CGFloat = self.view.frame.height
        
        let popupWidth = (screenWidth * 3)/4
        let popupHeight = (screenWidth * 4)/5
        
        // uiviewの作成　ポップアップ
        let testUIView = UIView()
        testUIView.frame = CGRect(
            x:screenWidth/8,
            y:screenHeight/3,
            width:popupWidth,
            height:popupHeight
        )
        testUIView.backgroundColor = UIColor.white
        testUIView.layer.cornerRadius = 10
        
        self.view.addSubview(testUIView)
        
        // 画面のどこかがタップされたらポップアップを消す処理
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.tapped(_:))
        )
        
        // デリゲートをセット
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        
        self.view.addGestureRecognizer(tapGesture)
        
        // ポップアップ以外のところを半透明のグレーに。
        self.view.backgroundColor = UIColor(
            red: 150/255,
            green: 150/255,
            blue: 150/255,
            alpha: 0.6
        )
    }
    // どこかタップされたときポップアップを消し去る関数
    @objc func tapped(_ sender: UITapGestureRecognizer){
        self.view.removeFromSuperview()
    }
 }

