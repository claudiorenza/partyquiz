//
//  OneBuzzer.swift
//  SimpleBuzzer
//
//  Created by Giovanni Frate on 15/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit

class OneBuzzer: UIView {
  
  @IBOutlet weak var buzzer: UIButton!
  var index = 0

  func setBuzzer() {
    buzzer.layer.cornerRadius = 50
  }
  
  @IBAction func pressBuzzer(_ sender: UIButton) {
    if index < 10 {
      index += 1
      buzzer.setTitle("\(index)", for: .normal)
      buzzer.setTitleColor(UIColor.white, for: .normal)
    } else {
      buzzer.isUserInteractionEnabled = false
    }
    print("Buzzing...")
  }
  
}
