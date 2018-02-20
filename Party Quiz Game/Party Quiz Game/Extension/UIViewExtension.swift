//
//  UIViewExtension.swift
//  SimpleBuzzer
//
//  Created by Pasquale Bruno on 17/02/2018.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func tutorialDismiss(view: UIView) {
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.fromValue = 1
    animation.toValue = 0
    animation.duration = 0.5
    
    layer.add(animation, forKey: nil)
  }
  
  func buzzerDown(view: UIView) {
    let animation = CABasicAnimation(keyPath: "position")
    animation.fromValue = NSValue(cgPoint: self.center)
    animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: (view.bounds.height + self.frame.height)))
    animation.duration = 0.5
    
    layer.add(animation, forKey: nil)
  }
  
  func questionBoxMoveLeft(view: UIView, initPosition: CGPoint) {
    let animation = CABasicAnimation(keyPath: "position")
    animation.fromValue = view.center
    animation.toValue = initPosition
    animation.duration = 0.5
    
    layer.add(animation, forKey: nil)
  }
  
  func changeBackgroundColor(initColor: UIColor, finalColor: UIColor) {
    let animation = CABasicAnimation(keyPath: "backgroundColor")
    animation.fromValue = initColor.cgColor
    animation.toValue = finalColor.cgColor
    animation.duration = 2
    
    layer.add(animation, forKey: nil)
  }
  
}
