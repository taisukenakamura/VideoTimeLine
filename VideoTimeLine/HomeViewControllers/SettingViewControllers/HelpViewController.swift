//
//  HelpViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/26.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // 戻る
    @IBAction func backButton(_ sender: Any) {
        
      self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func problemButon(_ sender: Any) {
        // アラート機能
        let alert = UIAlertController(title: "問題を報告", message: nil, preferredStyle: .alert)
        let use = UIAlertAction(title: "スパムまたは不正利用", style: .default)
        let problem = UIAlertAction(title: "機能の問題", style: .default)
        let feedBack = UIAlertAction(title: "フィードバック", style: .default)
        let video = UIAlertAction(title: "動画の画質の問題について", style: .default)
        let close = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alert.addAction(use)
        alert.addAction(problem)
        alert.addAction(feedBack)
        alert.addAction(video)
        alert.addAction(close)
        
        present(alert, animated: true)
        
    }
    
    
}
