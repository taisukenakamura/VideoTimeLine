//
//  ChatRoomInputView.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/24.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import Foundation
import UIKit

class ChatRoomInputView: UIView {
    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setFromXib()
    }
    
    func setFromXib() {
        let nib = UINib.init(nibName: "ChatRoomInputView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(view)// Storyboardから読み込んだレイアウトでビューを重ねて表示
    }
}
