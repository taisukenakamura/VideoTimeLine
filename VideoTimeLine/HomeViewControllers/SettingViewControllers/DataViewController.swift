//
//  DataViewController.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/26.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // 戻る
    @IBAction func backButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
