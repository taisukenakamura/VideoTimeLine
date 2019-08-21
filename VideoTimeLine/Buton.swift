//
//  Buton.swift
//  BoringSSL-GRPC
//
//  Created by 中村泰輔 on 2019/08/19.
//

import Foundation
import UIKit

extension UIButton {
    
    func createFloatingActionButton() {
      
       layer.cornerRadius = frame.height / 2
       layer.shadowOpacity = 0.25
       layer.shadowRadius = 5
       layer.shadowOffset = CGSize(width: 0, height: 10)
        
        
    }
    
}
