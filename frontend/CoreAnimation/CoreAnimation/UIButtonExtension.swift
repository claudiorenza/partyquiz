//
//  UIButtonExtension.swift
//  CoreAnimation
//
//  Created by Claudio Renza on 12/02/2018.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import Foundation
import UIKit

extension UIButton  {
  
  func entering()  {
    let enterAnimation = CABasicAnimation(keyPath: "position")
    
    
    var cgPointButtonInit = self.center
    let cgPointButtonFinal = cgPointButtonInit
    cgPointButtonInit.x = -self.frame.width
    
    
    enterAnimation.fromValue = NSValue(cgPoint: cgPointButtonInit)
    enterAnimation.toValue = NSValue(cgPoint: cgPointButtonFinal)
    
    
    enterAnimation.duration = 1.0
    enterAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    layer.add(enterAnimation, forKey: nil)
  }
  
  
}
