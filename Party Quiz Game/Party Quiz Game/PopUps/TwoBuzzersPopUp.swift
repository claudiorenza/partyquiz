//
//  TwoBuzzersPopUp.swift
//  SimpleBuzzer
//
//  Created by Giovanni Frate on 17/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit

class TwoBuzzersPopUp: UIView {

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var okOutlet: UIButton!
  @IBOutlet weak var leftHand: UIImageView!
  @IBOutlet weak var rightHand: UIImageView!
  
  func setViewElements(view: UIView) {
    label.layer.cornerRadius = 25.0
    label.layer.borderColor = UIColor.lightGray.cgColor
    label.layer.borderWidth = 1.0
    label.clipsToBounds = true
    okOutlet.layer.cornerRadius = 15.0
    okOutlet.layer.borderColor = UIColor.black.cgColor
    okOutlet.layer.borderWidth = 1.5
    leftHand.leftHandBuzzerTutorial(value: 0.8, view: view)
    rightHand.rightHandBuzzerTutorial(value: 1.2, view: view)
  }
  
  @IBAction func okAction(_ sender: UIButton) {
    self.tutorialDismiss(view: self)
    Singleton.shared.delayWithSeconds(0.1) {
      self.removeFromSuperview()
    }
  }
  
}
