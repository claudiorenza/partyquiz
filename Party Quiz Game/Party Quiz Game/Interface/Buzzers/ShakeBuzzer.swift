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
  var motionManager = CMMotionManager()
  
  var indicatorViewInterval: CGFloat = 0.0

  @IBOutlet weak var viewOutlet: UIView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet var indicatorView: UIView!

  @objc func beginShaking() {
    motionManager.accelerometerUpdateInterval = 0.1
    motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {
      (data, error) in
      if let myData = data {
        if self.index < 10 {
          if (myData.acceleration.x > 1.2 || myData.acceleration.y > 1.2 || myData.acceleration.z > 1.2) {
            self.index += 1
            self.label.text = "\(self.index)"
            UIView.animate(withDuration: 0.2, animations: {
              self.indicatorView.frame = CGRect(x: self.indicatorView.frame.origin.x, y: self.indicatorView.frame.origin.y, width: self.indicatorView.frame.width, height: (self.indicatorViewInterval * CGFloat(10-self.index)/10))
            })
          }
        } else {
          self.stopShaking()
          self.viewOutlet.buzzerDown(view: self.viewOutlet)
          Singleton.shared.delayWithSeconds(0.4, completion: {
            self.removeFromSuperview()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadProgressView10"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "answers"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "buzzer"), object: nil)
          })
        }
      }
    }
  }
  
  func setRoundedView() {
    viewOutlet.layer.cornerRadius = 25.0
    viewOutlet.layer.borderColor = UIColor.borderColorGray()
    viewOutlet.layer.borderWidth = 6.0
  }
  
  func setRoundedLabel() {
    label.layer.cornerRadius = 25
    label.clipsToBounds = true
  }
  
  func setIndicatorView() {
    indicatorViewInterval = indicatorView.frame.origin.y + indicatorView.frame.height
    indicatorView.layer.cornerRadius = 25.0
  }
  
  
  func loadPopUp() {
    NotificationCenter.default.addObserver(self, selector: #selector(self.beginShaking), name: NSNotification.Name(rawValue: "beginShaking"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.stopShaking), name: NSNotification.Name(rawValue: "stopShaking"), object: nil)
    if let shakeBuzzerPopUp = Bundle.main.loadNibNamed("ShakeBuzzerPopUp", owner: self, options: nil)?.first as? ShakeBuzzerPopUp {
      self.addSubview(shakeBuzzerPopUp)
      shakeBuzzerPopUp.setViewElements()
      shakeBuzzerPopUp.frame = self.bounds
    }
  }
  
  @objc func stopShaking() {
    motionManager.stopAccelerometerUpdates()
  }

}
