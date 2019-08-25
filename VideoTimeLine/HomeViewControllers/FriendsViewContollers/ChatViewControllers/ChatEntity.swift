//
//  ChatEntity.swift
//  VideoTimeLine
//
//  Created by 中村泰輔 on 2019/08/24.
//  Copyright © 2019 icannot.t.n. All rights reserved.
//

import Foundation
import UIKit

public class ChatEntity {
    var text = ""
    var time = ""
    var userType: UserType
    
    public init(text: String, time: String, userType: UserType) {
        self.text = text
        self.time = time
        self.userType = userType
    }
    
    public func isMyChat() -> Bool {
        return userType == .I
    }
}

public enum UserType {
    case I
    case You
}
