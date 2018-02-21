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
  @IBOutlet weak var view: UIView!
  
  var index = 0
  var total = 10
  
  func setBuzzer() {
    buzzer.layer.cornerRadius = 25.0
    buzzer.layer.borderWidth = 6.0
    buzzer.layer.borderColor = UIColor.borderColorGray()
  }
  
  @IBAction func pressBuzzer(_ sender: UIButton) {
    if index < 10 {
      index += 1
      total = total - 1
      buzzer.setTitle("\(total)", for: .normal)
      buzzer.setTitleColor(UIColor.white, for: .normal)
    } else {
      view.buzzerDown(view: view)
      buzzer.isUserInteractionEnabled = false
      Singleton.shared.delayWithSeconds(0.4, completion: {
        self.removeFromSuperview()
      })
    }
  }
  
  func loadPopUp(view: UIView) {
    if let oneBuzzerPopUp = Bundle.main.loadNibNamed("OneBuzzerPopUp", owner: self, options: nil)?.first as? OneBuzzerPopUp {
      self.addSubview(oneBuzzerPopUp)
      oneBuzzerPopUp.setViewElements(view: view)
      oneBuzzerPopUp.frame = self.bounds
    }
  }
  
}
