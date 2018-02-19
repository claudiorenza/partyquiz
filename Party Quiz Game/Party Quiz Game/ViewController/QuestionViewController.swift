//
//  MainViewController.swift
//  Party Quiz Game
//
//  Created by Giovanni Frate on 12/02/18.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
  
  // - MARK: 1: Variables and Outlets declaration
  @IBOutlet weak var buzzerView: UIView!
  @IBOutlet weak var progressControllerView: UIView!
  var index = 0
  
  // - MARK: 2: ViewDidLoad
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
        oneBuzzer.loadPopUp()
        oneBuzzer.setBuzzer()
        oneBuzzer.frame = buzzerView.bounds
      }
    } else if index == 1 {
      if let twoBuzzers = Bundle.main.loadNibNamed("TwoBuzzers", owner: self, options: nil)?.first as? TwoBuzzers {
        buzzerView.addSubview(twoBuzzers)
        twoBuzzers.loadPopUp()
        twoBuzzers.setBuzzers()
        twoBuzzers.frame = buzzerView.bounds
      }
    } else if index == 2 {
      if let shakeBuzzer = Bundle.main.loadNibNamed("ShakeBuzzer", owner: self, options: nil)?.first as? ShakeBuzzer {
        buzzerView.addSubview(shakeBuzzer)
        shakeBuzzer.loadPopUp()
        shakeBuzzer.setRoundedView()
        shakeBuzzer.setRoundedLabel()
        shakeBuzzer.beginShaking()
        shakeBuzzer.frame = buzzerView.bounds
      }
    } else {
      if let blowBuzzer = Bundle.main.loadNibNamed("BlowBuzzer", owner: self, options: nil)?.first as? BlowBuzzer {
        buzzerView.addSubview(blowBuzzer)
        blowBuzzer.loadPopUp()
        blowBuzzer.setRoundedView()
        blowBuzzer.startBlowing()
        blowBuzzer.frame = buzzerView.bounds
      }
    }
  }
  
  @IBAction func buttonAction(_ sender: UIButton) {
    randomBuzzers()
    loadProgressView()
  }
  
}
