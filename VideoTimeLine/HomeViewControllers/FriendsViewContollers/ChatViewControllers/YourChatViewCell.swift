//
//  YourChatViewCell.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/24.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit

class YourChatViewCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var textViewWidthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
        self.textView.layer.cornerRadius = 15// 角を丸める
        self.addSubview(YourBalloonView(frame: CGRect(x: textView.frame.minX-10, y: textView.frame.minY-10, width: 50, height: 50)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
extension YourChatViewCell {
    func updateCell(text: String, time: String) {
        self.textView?.text = text
        self.timeLabel?.text = time
        
        let frame = CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude)
        var rect = self.textView.sizeThatFits(frame)
        if(rect.width<30){
            rect.width=30
        }
        textViewWidthConstraint.constant = rect.width//テキストが短くても最小のビューの幅を30とする
    }
}
