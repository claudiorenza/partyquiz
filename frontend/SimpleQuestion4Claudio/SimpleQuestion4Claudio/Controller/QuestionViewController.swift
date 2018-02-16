//
//  ViewController.swift
//  SimpleQuestion4Claudio
//
//  Created by Giovanni Frate on 13/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

  @IBOutlet weak var buzzerView: UIView!
  @IBOutlet weak var progressControllerView: UIView!
  var index = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadProgressView()
    randomBuzzers()
  }
  
  // - MARK: 3: Method that loads the progress view
  func loadProgressView() {
    if let progressView = Bundle.main.loadNibNamed("ProgressView", owner: self, options: nil)?.first as? ProgressView {
      progressControllerView.addSubview(progressView)
      progressView.manageProgress()
      progressView.frame = progressControllerView.bounds
    }
  }
  
  // - MARK: 4: Method that generates random buzzers
  func randomBuzzers() {
    index = Int(arc4random_uniform(4))
    if index == 0 {
      if let oneBuzzer = Bundle.main.loadNibNamed("OneBuzzer", owner: self, options: nil)?.first as? OneBuzzer {
        buzzerView.addSubview(oneBuzzer)
        oneBuzzer.setBuzzer()
        oneBuzzer.frame = buzzerView.bounds
      }
    } else if index == 1 {
      if let twoBuzzers = Bundle.main.loadNibNamed("TwoBuzzers", owner: self, options: nil)?.first as? TwoBuzzers {
        buzzerView.addSubview(twoBuzzers)
        twoBuzzers.setBuzzers()
        twoBuzzers.frame = buzzerView.bounds
      }
    } else if index == 2 {
      if let shakeBuzzer = Bundle.main.loadNibNamed("ShakeBuzzer", owner: self, options: nil)?.first as? ShakeBuzzer {
        buzzerView.addSubview(shakeBuzzer)
        shakeBuzzer.setRoundedView()
        shakeBuzzer.setRoundedLabel()
        shakeBuzzer.beginShaking()
        shakeBuzzer.frame = buzzerView.bounds
      }
    } else {
      if let blowBuzzer = Bundle.main.loadNibNamed("BlowBuzzer", owner: self, options: nil)?.first as? BlowBuzzer {
        buzzerView.addSubview(blowBuzzer)
        blowBuzzer.setRoundedView()
        blowBuzzer.startBlowing()
        blowBuzzer.frame = buzzerView.bounds
      }
    }
  }

}

