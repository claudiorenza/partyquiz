//
//  ShakeBuzzerPopUp.swift
//  SimpleBuzzer
//
//  Created by Giovanni Frate on 17/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit

class ShakeBuzzerPopUp: UIView {

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var okOutlet: UIButton!
  @IBOutlet weak var imageToAnimate: UIImageView!
  
  func setViewElements() {
    self.layer.cornerRadius = 25.0
    self.layer.borderColor = UIColor.borderColorGray()
    self.layer.borderWidth = 6.0
    okOutlet.layer.cornerRadius = 15.0
    okOutlet.layer.borderColor = UIColor.black.cgColor
    okOutlet.layer.borderWidth = 1.5
    imageToAnimate.shakeBuzzerTutorial()
  }
  
  @IBAction func okAction(_ sender: UIButton) {
    self.tutorialDismiss(view: self)
    Singleton.shared.delayWithSeconds(0.1) {
      self.removeFromSuperview()
    }
  }
}
