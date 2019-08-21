//
//  FloatingActionButton.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/21.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        layer.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
    
}

