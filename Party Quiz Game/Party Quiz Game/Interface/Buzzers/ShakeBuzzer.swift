//
//  ShakeBuzzer.swift
//  SimpleBuzzer
//
//  Created by Giovanni Frate on 15/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit
import CoreMotion

class ShakeBuzzer: UIView {

  var index = 0
//  var colorArray: [UIColor] = [
//    UIColor.green,
//    UIColor.red,
//    UIColor.blue,
//    UIColor.cyan,
//    UIColor.magenta,
//    UIColor.gray,
//    UIColor.brown,
//    UIColor.purple,
//    UIColor.orange,
//    UIColor.yellow
//  ]
  var motionManager = CMMotionManager()
  @IBOutlet weak var viewOutlet: UIView!
  @IBOutlet weak var label: UILabel!
  
  func beginShaking() {
    motionManager.accelerometerUpdateInterval = 0.1
    motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {
      (data, error) in
      if let myData = data {
        if self.index < 10 {
          if (myData.acceleration.x > 1.2 || myData.acceleration.y > 1.2 || myData.acceleration.z > 1.2) {
            self.index += 1
            self.label.text = "\(self.index)"
          }
        } else {
          print("ELSE")
          self.motionManager.stopAccelerometerUpdates()
          self.removeFromSuperview()
        }
      }
    }
  }
  
  func setRoundedView() {
    viewOutlet.layer.cornerRadius = 50
    viewOutlet.layer.borderColor = UIColor.black.cgColor
    viewOutlet.layer.borderWidth = 1
  }
  
  func setRoundedLabel() {
    label.layer.cornerRadius = 25
    label.clipsToBounds = true
  }
  
  func loadPopUp() {
    if let shakeBuzzerPopUp = Bundle.main.loadNibNamed("ShakeBuzzerPopUp", owner: self, options: nil)?.first as? ShakeBuzzerPopUp {
      self.addSubview(shakeBuzzerPopUp)
      shakeBuzzerPopUp.setViewElements()
      shakeBuzzerPopUp.frame = self.bounds
    }
  }

}
