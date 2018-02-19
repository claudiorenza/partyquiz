//
//  UIImageViewExtension.swift
//  SimpleBuzzer
//
//  Created by Pasquale Bruno on 17/02/2018.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {

  func oneBuzzerTutorial(value: Float) {
    
    let animation = CABasicAnimation(keyPath: "position")
//    animation.fromValue = self.center
//    print ("\(position)")
    animation.fromValue = CGPoint(x: self.center.x, y: self.center.y)
    animation.toValue = CGPoint(x: self.center.x, y: (self.center.y * CGFloat(value)))
    animation.duration = 0.5
    animation.autoreverses = true
    animation.repeatCount = Float.infinity
    
    layer.add(animation, forKey: nil)
  }
  
  func shakeBuzzerTutorial() {
    let animation = CABasicAnimation(keyPath: "transform.rotation")
    animation.fromValue = Float.pi * 0.25
    animation.toValue = -Float.pi * 0.25
    animation.duration = 0.3
    animation.autoreverses = true
    animation.repeatCount = Float.infinity
    
    layer.add(animation, forKey: nil)
  }
  
  func blowBuzzerTutorial() {
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.fromValue = 1
    animation.toValue = 0.1
    animation.duration = 0.3
    animation.autoreverses = true
    animation.repeatCount = Float.infinity
    
    layer.add(animation, forKey: nil)
  }
  
  //change background color

}
