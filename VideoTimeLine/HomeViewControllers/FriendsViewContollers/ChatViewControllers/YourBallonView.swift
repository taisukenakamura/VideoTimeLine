//
//  YourBallonView.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/24.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import Foundation
import UIKit

class YourBalloonView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        let line = UIBezierPath()//吹き出しの口部分を描画
        UIColor.white.setFill()
        UIColor.clear.setStroke()
        line.move(to: CGPoint(x: 20, y: 15))
        line.addQuadCurve(to: CGPoint(x: 5, y: 5), controlPoint: CGPoint(x: 5, y: 10))
        line.addQuadCurve(to: CGPoint(x: 10, y: 25), controlPoint: CGPoint(x: 0, y: 10))
        line.close()
        line.fill()
        line.stroke()
    }
}
