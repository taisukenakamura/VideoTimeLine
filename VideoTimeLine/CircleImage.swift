//
//  CircleImage.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/22.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
// imageViewを丸くする
class CircleImageView: UIImageView {
    @IBInspectable var borderColor :  UIColor = UIColor.black
    @IBInspectable var borderWidth :  CGFloat = 0.1
    
    override var image: UIImage? {
        didSet{
            layer.masksToBounds = false
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = borderWidth
            layer.cornerRadius = frame.height/2
            clipsToBounds = true
        }
    }
}
