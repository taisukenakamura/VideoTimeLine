//
//  FuloatingActionButton.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/21.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import UIKit

class FloatingActionButton: UIButton {

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        UIView.animate(withDuration: 0.3, animations: {
            
            
            if self.transform == .identity {
                
                self.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
               self.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.2509803922, blue: 0.3843137255, alpha: 1)  // f04062
            } else {
                
                self.transform = .identity
                
                self.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) // d13855
            }
        })
        return super.beginTracking(touch, with: event)
    }
    
//    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
//        <#code#>
//    }
    
  
}
