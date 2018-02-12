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
    enterAnimation.fromValue = [0, 0]
    enterAnimation.toValue = [100, 100]
    
    
    layer.add(enterAnimation, forKey: nil)
  }
  
  
}
