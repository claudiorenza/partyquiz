//
//  UIColorExtension.swift
//  Party Quiz Game
//
//  Created by Claudio Renza on 19/02/2018.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  
  class func borderColorGray()  -> CGColor  {
    return UIColor(red: 96.0/255.0, green: 96.0/255.0, blue: 96.0/255.0, alpha: 1.0).cgColor
  }
  
    convenience init(hex: String) {
      let scanner = Scanner(string: hex)
      scanner.scanLocation = 0
      
      var rgbValue: UInt64 = 0
      
      scanner.scanHexInt64(&rgbValue)
      
      let r = (rgbValue & 0xff0000) >> 16
      let g = (rgbValue & 0xff00) >> 8
      let b = rgbValue & 0xff
      
      self.init(
        red: CGFloat(r) / 0xff,
        green: CGFloat(g) / 0xff,
        blue: CGFloat(b) / 0xff, alpha: 1
      )
    }
}
