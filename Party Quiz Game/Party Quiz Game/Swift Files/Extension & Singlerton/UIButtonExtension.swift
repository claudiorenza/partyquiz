//
//  UIButtonExtension.swift
//  Party Quiz Game
//
//  Created by Claudio Renza on 14/02/2018.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import Foundation
import UIKit

extension UIButton  {
  
  func entering(directionFrom: String, view: UIView) {
    let animation = CABasicAnimation(keyPath: "position")
    var cgPointButtonInit = self.center
    let cgPointButtonFinal = cgPointButtonInit
    
    if(directionFrom == "left") {
      cgPointButtonInit.x = -self.frame.width
    } else if (directionFrom == "right")    {
      cgPointButtonInit.x = view.bounds.width + self.frame.width
    }
    
    animation.fromValue = NSValue(cgPoint: cgPointButtonInit)
    animation.toValue = NSValue(cgPoint: cgPointButtonFinal)
    animation.duration = 1.0
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    layer.add(animation, forKey: nil)
  }
  
  func exit(directionTo: String, view: UIView) {
    let animation = CABasicAnimation(keyPath: "position")
    var finalPosition = CGPoint()
    
    if(directionTo == "left") {
      finalPosition.x = view.bounds.width + self.frame.width
    } else if (directionTo == "right") {
      finalPosition.x = -self.frame.width
    }
    
    animation.fromValue = self.center
    animation.toValue = CGPoint(x: finalPosition.x, y: self.center.y)
    animation.duration = 1.0
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    layer.add(animation, forKey: nil)
  }
}

