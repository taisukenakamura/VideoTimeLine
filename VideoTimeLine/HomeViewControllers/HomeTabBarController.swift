//
//  HomeTabBarController.swift
//  
//
//  Created by 中村泰輔 on 2019/08/20.
//

import UIKit
import SwipeableTabBarController

class HomeTabBarController: SwipeableTabBarController {
    // スクロール機能の追加
    override func viewDidLoad() {
        super.viewDidLoad()

        if let viewControllers = viewControllers {
            selectedViewController = viewControllers[1]
            
            
        }
        
        /// Set the animation type for swipe
        swipeAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
        
        /// Set the animation type for tap
        tapAnimatedTransitioning?.animationType = SwipeAnimationType.push
        
        /// if you want cycling switch tab, set true 'isCyclingEnabled'
        isCyclingEnabled = true
        
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            // Handle didSelect viewController method here
          
        }
    }
    
    
    
}
