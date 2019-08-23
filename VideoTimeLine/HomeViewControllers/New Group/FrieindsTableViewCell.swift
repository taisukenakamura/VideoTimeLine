//
//  FireindsTableViewCell.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/22.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit
import CoreLocation

class FrieindsTableViewCell: UITableViewCell {

    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var firendNameLabel: UILabel!
    
    @IBOutlet weak var locationButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
