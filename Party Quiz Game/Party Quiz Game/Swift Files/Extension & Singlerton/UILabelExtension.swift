//
//  UILabelExtension.swift
//  Party Quiz Game
//
//  Created by Pasquale Bruno on 20/02/2018.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
  func questionBoxMoveLeft(view: UIView, initPosition: CGPoint) {
    let animation = CABasicAnimation(keyPath: "position")
    animation.fromValue = self.center
    animation.toValue = CGPoint(x: initPosition.x, y: self.center.y)
    animation.duration = 0.5
    
    layer.add(animation, forKey: nil)
  }
  
  func logoEnter(view: UIView, enter: String) {
    let animation = CASpringAnimation(keyPath: "position")
    
    var startingPoint = CGPoint()
    if enter == "Up" {
      startingPoint.y = -view.bounds.midY
    } else if enter == "Down" {
      startingPoint.y = view.bounds.height + view.bounds.midY
    }
    
    animation.fromValue = CGPoint(x: view.bounds.midX, y: startingPoint.y)
    animation.toValue = self.center
    
    layer.add(animation, forKey: nil)
  }
}
