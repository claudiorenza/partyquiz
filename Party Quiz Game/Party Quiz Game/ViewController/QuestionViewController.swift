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
  @IBOutlet var questionOutlet: UILabel!
  @IBOutlet var buttonAnswerOne: UIButton!
  @IBOutlet var buttonAnswerTwo: UIButton!
  @IBOutlet var buttonAnswerThree: UIButton!
  @IBOutlet var buttonAnswerFour: UIButton!
  
  let backgoundBase = UIColor(red: 67/255, green: 59/255, blue: 240/255, alpha: 1)
  let backgoundLilla = UIColor(red: 189/255, green: 16/255, blue: 224/255, alpha: 1)
  let background2 = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
  let background3 = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
  let background4 = UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
  // black is good
  // orange is good
  var index = 0
  var point = CGPoint()

  // - MARK: 2: ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = backgoundBase
    setAnswersQuestion()
    loadProgressView()
    
//    NotificationCenter.default.addObserver(self, selector: #selector(self.moveQuestionBoxToOrigin), name: NSNotification.Name(rawValue: "twoBuzzersException"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.buzzerSignal), name: NSNotification.Name(rawValue: "buzzer"), object: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
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
        oneBuzzer.loadPopUp(view: view)
        oneBuzzer.setBuzzer()
        oneBuzzer.frame = buzzerView.bounds
        changeBackgroundColor(finalColor: UIColor.orange)
      }
    } else if index == 1 {
      point.x = questionOutlet.center.x
      questionOutlet.center.x = view.bounds.width * 0.465
      if let twoBuzzers = Bundle.main.loadNibNamed("TwoBuzzers", owner: self, options: nil)?.first as? TwoBuzzers {
        buzzerView.addSubview(twoBuzzers)
        twoBuzzers.loadPopUp(view: view)
        twoBuzzers.setBuzzers()
        twoBuzzers.frame = buzzerView.bounds
        changeBackgroundColor(finalColor: UIColor.red)
      }
    } else if index == 2 {
      if let shakeBuzzer = Bundle.main.loadNibNamed("ShakeBuzzer", owner: self, options: nil)?.first as? ShakeBuzzer {
        buzzerView.addSubview(shakeBuzzer)
        shakeBuzzer.loadPopUp()
        shakeBuzzer.setRoundedView()
        shakeBuzzer.setRoundedLabel()
        shakeBuzzer.setIndicatorView()
        shakeBuzzer.beginShaking()
        shakeBuzzer.frame = buzzerView.bounds
        changeBackgroundColor(finalColor: UIColor.black)
      }
    } else {
      if let blowBuzzer = Bundle.main.loadNibNamed("BlowBuzzer", owner: self, options: nil)?.first as? BlowBuzzer {
        buzzerView.addSubview(blowBuzzer)
        blowBuzzer.loadPopUp()
        blowBuzzer.setRoundedView()
        blowBuzzer.setIndicatorView()
        blowBuzzer.startBlowing()
        blowBuzzer.frame = buzzerView.bounds
        changeBackgroundColor(finalColor: backgoundLilla)
      }
    }
  }
  
  func setAnswersQuestion() {
    questionOutlet.layer.cornerRadius = 25.0
    questionOutlet.clipsToBounds = true
    questionOutlet.layer.borderWidth = 6.0
    questionOutlet.layer.borderColor = UIColor.borderColorGray()
    
    buttonAnswerOne.layer.cornerRadius = 25
    buttonAnswerOne.layer.borderColor = UIColor.borderColorGray()
    buttonAnswerOne.layer.borderWidth = 6.0
    
    buttonAnswerTwo.layer.cornerRadius = 25
    buttonAnswerTwo.layer.borderColor = UIColor.borderColorGray()
    buttonAnswerTwo.layer.borderWidth = 6.0
      
    buttonAnswerThree.layer.cornerRadius = 25
    buttonAnswerThree.layer.borderColor = UIColor.borderColorGray()
    buttonAnswerThree.layer.borderWidth = 6.0
    
    buttonAnswerFour.layer.cornerRadius = 25
    buttonAnswerFour.layer.borderColor = UIColor.borderColorGray()
    buttonAnswerFour.layer.borderWidth = 6.0
  }
  
  @IBAction func buttonAction(_ sender: UIButton) {
    randomBuzzers()
    loadProgressView()
  }
  
  func changeBackgroundColor(finalColor: UIColor) {
    view.changeBackgroundColor(initColor: view.backgroundColor!, finalColor: finalColor)
    Singleton.shared.delayWithSeconds(1.8, completion: {
      self.view.backgroundColor = finalColor
    })
  }
  
  @objc func buzzerSignal() {
    //invio multipeer agli altri giocatori
    self.moveQuestionBoxToOrigin()
  }
  
  /*@objc*/ func moveQuestionBoxToOrigin() {
    questionOutlet.questionBoxMoveLeft(view: view, initPosition: point)
    Singleton.shared.delayWithSeconds(0.4) {
      self.questionOutlet.center.x = self.point.x
    }
  }
}
