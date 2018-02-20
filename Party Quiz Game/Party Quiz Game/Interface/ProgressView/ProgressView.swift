//
//  ProgressView.swift
//  SimpleBuzzer
//
//  Created by Giovanni Frate on 16/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit

class ProgressView: UIView {
  
  @IBOutlet weak var progressView: UIProgressView!
  
  var totalSeconds = 30
  var currentSeconds = 0
  var timer : Timer!
  
  let myOrange = UIColor(red: 1.00, green: 0.67, blue: 0.00, alpha: 1.0)
  
  func manageProgress() {
    currentSeconds = totalSeconds
    // Progress view
    progressView.progress = 1.0
    progressView.trackTintColor = UIColor.gray
    progressView.progressTintColor = UIColor.green
    // Set rounded edges for the progress view
    progressView.layer.cornerRadius = 5
    progressView.clipsToBounds = true
    // Set rounded edges for the inner bar
    progressView.layer.sublayers![1].cornerRadius = 5
    progressView.subviews[1].clipsToBounds = true
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTimer), userInfo: nil, repeats: true)
  }
  
  @objc func decreaseTimer() {
    if currentSeconds > 0 {
      currentSeconds -= 1
      if totalSeconds >= 20 {
        if (currentSeconds < 6) {
          progressView.progressTintColor = UIColor.red
        } else if (currentSeconds < ((totalSeconds/3) + 1)) {
          progressView.progressTintColor = myOrange
        } else if (currentSeconds < ((totalSeconds/2) + 1)) {
          progressView.progressTintColor = UIColor.yellow
        }
      } else {
        if (currentSeconds < ((totalSeconds/4) + 1)) {
          progressView.progressTintColor = UIColor.red
        } else if (currentSeconds < ((totalSeconds/3) + 1)) {
          progressView.progressTintColor = myOrange
        } else if (currentSeconds < ((totalSeconds/2) + 1)) {
          progressView.progressTintColor = UIColor.yellow
        }
      }
      UIView.animate(withDuration: 1.6, animations: {
        self.progressView.setProgress(Float(self.progressView.progress - (1 / Float(self.totalSeconds))), animated: true)
      })
    } else {
      timer.invalidate()
    }
  }
}
