//
//  UIView+Card.swift
//  PocketRockets
//
//  Created by Yi Wang on 7/9/19.
//  Copyright © 2019 Terry Wang. All rights reserved.
//

import UIKit

extension UIView {
    /// Add shadow to the current view
    func addShadowToCard(shadowRadius: CGFloat = 8.0, shadowOpacity: Float = 0.4, shadowColor: CGColor = UIColor.gray.cgColor, shadowOffset: CGSize = CGSize(width: 0, height: 5)) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
    
    /**
     Set corner radius to resemble a card.
     - parameter radius: corner radius for this view.
     */
    func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    /**
     Fade transition aniamtion.
     - parameter duration: duration of this animation.
     */
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
