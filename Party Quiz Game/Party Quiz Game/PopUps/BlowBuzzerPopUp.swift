//
//  BlowBuzzerPopUp.swift
//  SimpleBuzzer
//
//  Created by Giovanni Frate on 17/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit

class BlowBuzzerPopUp: UIView {

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var okOutlet: UIButton!
  @IBOutlet weak var image: UIImageView!
  
  func setViewElements() {
    label.layer.cornerRadius = 25.0
    label.layer.borderColor = UIColor.lightGray.cgColor
    label.layer.borderWidth = 1.0
    label.clipsToBounds = true
    okOutlet.layer.cornerRadius = 15.0
    okOutlet.layer.borderColor = UIColor.black.cgColor
    okOutlet.layer.borderWidth = 1.5
    image.blowBuzzerTutorial()
  }
  
  @IBAction func okAction(_ sender: UIButton) {
    self.removeFromSuperview()
  }
  
}
