//
//  TwoBuzzers.swift
//  SimpleBuzzer
//
//  Created by Giovanni Frate on 15/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit

class TwoBuzzers: UIView {
  
  @IBOutlet weak var leftBuzzer: UIButton!
  @IBOutlet weak var rightBuzzer: UIButton!
  @IBOutlet weak var label: UILabel!
  
  var index = 0
  
  func setBuzzers() {
    leftBuzzer.layer.cornerRadius = 50
    rightBuzzer.layer.cornerRadius = 50
    leftBuzzer.isUserInteractionEnabled = false
  }
  
  @IBAction func pressLeftBuzzer(_ sender: UIButton) {
    if index < 10 {
      index += 1
      label.text = "\(index)"
      leftBuzzer.isUserInteractionEnabled = false
      rightBuzzer.isUserInteractionEnabled = true
    } else {
      leftBuzzer.isUserInteractionEnabled = false
    }
  }
  
  @IBAction func pressRightBuzzer(_ sender: UIButton) {
    if index < 10 {
      index += 1
      label.text = "\(index)"
      leftBuzzer.isUserInteractionEnabled = true
      rightBuzzer.isUserInteractionEnabled = false
    } else {
      leftBuzzer.isUserInteractionEnabled = false
    }
  }
  
}
