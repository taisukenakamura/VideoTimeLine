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

//extension RAMItemAnimation {
//    
//
//        func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
//            playBounceAnimation(icon)
//            textLabel.textColor = textSelectedColor
//        }
//
//        func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
//            textLabel.textColor = defaultTextColor
//        }
//
//        func selectedState(_ icon: UIImageView, textLabel: UILabel) {
//            textLabel.textColor = textSelectedColor
//        }
//        
//        func playBounceAnimation(_ icon : UIImageView) {
//
//            let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
//            bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
//            bounceAnimation.duration = TimeInterval(duration)
//            bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
//
//            icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
//       }
//    }
//


