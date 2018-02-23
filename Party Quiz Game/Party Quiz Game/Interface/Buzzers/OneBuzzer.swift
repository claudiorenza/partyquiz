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
  @IBOutlet var outletCounter: UILabel!
  
  var index = 10
  var audioBuzz = Audio(fileName: "buzz", typeName: "m4a")
  
  func setBuzzer() {
    buzzer.layer.cornerRadius = 25.0
    buzzer.layer.borderWidth = 6.0
    buzzer.layer.borderColor = UIColor.borderColorGray()
    outletCounter.text = "\(index)"
  }
  
  @IBAction func pressBuzzer(_ sender: UIButton) {
    AudioSingleton.shared.audioButtonClick.player.play()
    index -= 1
    outletCounter.text = "\(index)"
    if index == 0 {
      audioBuzz.player.play()
      view.buzzerDown(view: view)
      buzzer.isUserInteractionEnabled = false
      Singleton.shared.delayWithSeconds(0.4, completion: {
        self.removeFromSuperview()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadProgressView10"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "answers"), object: nil)
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
