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
  @IBOutlet weak var view: UIView!
  
  var index = 10
  var audioBuzz = Audio(fileName: "buzz", typeName: "m4a")
  var audioButtonClick = Audio(fileName: "buttonClick", typeName: "m4a")
  
  func setBuzzers() {
    leftBuzzer.layer.cornerRadius = 25
    leftBuzzer.layer.borderWidth = 6.0
    leftBuzzer.layer.borderColor = UIColor.borderColorGray()
    
    rightBuzzer.layer.cornerRadius = 25
    rightBuzzer.layer.borderWidth = 6.0
    rightBuzzer.layer.borderColor = UIColor.borderColorGray()
    
    label.layer.cornerRadius = 15
    label.layer.borderWidth = 3.0
    label.layer.borderColor = UIColor.borderColorGray()
    label.clipsToBounds = true
    label.text = "\(index)"
    
    leftBuzzer.isUserInteractionEnabled = true
    rightBuzzer.isUserInteractionEnabled = false
  }
  
  @IBAction func pressLeftBuzzer(_ sender: UIButton) {
    audioButtonClick.player.play()
    index -= 1
    label.text = "\(index)"
    if index > 0 {
      leftBuzzer.isUserInteractionEnabled = false
      rightBuzzer.isUserInteractionEnabled = true
    } else {
      rightBuzzer.isUserInteractionEnabled = false
    }
  }
  
  @IBAction func pressRightBuzzer(_ sender: UIButton) {
    audioButtonClick.player.play()
    index -= 1
    label.text = "\(index)"
    if index > 0 {
      leftBuzzer.isUserInteractionEnabled = true
      rightBuzzer.isUserInteractionEnabled = false
    } else {
      audioBuzz.player.play()
      view.buzzerDown(view: view)
      leftBuzzer.isUserInteractionEnabled = false
      rightBuzzer.isUserInteractionEnabled = false
      Singleton.shared.delayWithSeconds(0.4, completion: {
        self.removeFromSuperview()
      })
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadProgressView10"), object: nil)
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "twoBuzzersException"), object: nil)
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "answers"), object: nil)
    }
  }
  
  func loadPopUp(view: UIView) {
    if let twoBuzzersPopUp = Bundle.main.loadNibNamed("TwoBuzzersPopUp", owner: self, options: nil)?.first as? TwoBuzzersPopUp {
      self.addSubview(twoBuzzersPopUp)
      twoBuzzersPopUp.setViewElements(view: view)
      twoBuzzersPopUp.frame = self.bounds
    }
  }
  
}
