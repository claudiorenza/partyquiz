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
}
