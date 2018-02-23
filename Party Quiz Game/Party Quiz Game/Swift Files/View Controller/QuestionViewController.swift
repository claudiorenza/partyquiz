//
//  MainViewController.swift
//  Party Quiz Game
//
//  Created by Claudio Renza on 12/02/18.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit
import AVFoundation

class QuestionViewController: UIViewController {
  
  // - MARK: 1: Variables and Outlets declaration
  static let shared = QuestionViewController()
  @IBOutlet weak var buzzerView: UIView!
  @IBOutlet weak var progressControllerView: UIView!
  @IBOutlet var questionOutlet: UILabel!
  @IBOutlet var buttonAnswerOne: UIButton!
  @IBOutlet var buttonAnswerTwo: UIButton!
  @IBOutlet var buttonAnswerThree: UIButton!
  @IBOutlet var buttonAnswerFour: UIButton!
  @IBOutlet weak var onHoldView: UIView!
  @IBOutlet weak var onHoldLabel: UILabel!
  
  var audioAnswerRight = Audio(fileName: "answerRight", typeName: "m4a")
  var audioAnswerWrong = Audio(fileName: "answerWrong", typeName: "m4a")
  
  var question: [String:String] = ["text":"Capitale dell'Italia", "correctlyAnswer":"Roma", "wrongAnswer1":"Torino", "wrongAnswer2":"Napoli", "wrongAnswer3":"Firenze", "category":"Geografia"]
  
  var timerReceiveBuzz: Timer!        //SIMULATION
  var timerReceiveWrongAnswer: Timer! //SIMULATION
  var timerReceiveRightAnswer: Timer! //SIMULATION
  
  let backgoundBlueOcean = UIColor(red: 67/255, green: 59/255, blue: 240/255, alpha: 1)
  let backgoundLilla = UIColor(red: 189/255, green: 16/255, blue: 224/255, alpha: 1)
  let backgroundRed = UIColor(red: 243/255, green: 75/255, blue: 75/255, alpha: 1)

  var indexBuzzer = 0
  var point = CGPoint()
  
  
  // JOHNNY'S ZONE
  var question: [String:String] = ["text": PeerManager.peerShared.question, "correctlyAnswer": PeerManager.peerShared.correct, "wrongAnswer1": PeerManager.peerShared.wrong1, "wrongAnswer2": PeerManager.peerShared.wrong2, "wrongAnswer3": PeerManager.peerShared.wrong3]
  
  // END OF JOHNNY'S ZONE
  

  // - MARK: 2: ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = backgoundBlueOcean
    setAnswersQuestion()
    NotificationCenter.default.addObserver(self, selector: #selector(self.loadProgressView30), name: NSNotification.Name(rawValue: "loadProgressView30"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.loadProgressView10), name: NSNotification.Name(rawValue: "loadProgressView10"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.timeOut), name: NSNotification.Name(rawValue: "timeOut"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.answersAppear), name: NSNotification.Name(rawValue: "answers"), object: nil)
    let currentQuestion = CoreDataManager.shared.questionDictionary[0]
    questionOutlet.text = currentQuestion["text"]
    buttonAnswerOne.setTitle(currentQuestion["wrongAnswer1"], for: .normal)
    buttonAnswerTwo.setTitle(currentQuestion["wrongAnswer2"], for: .normal)
    buttonAnswerThree.setTitle(currentQuestion["correctlyAnswer"], for: .normal)
    buttonAnswerFour.setTitle(currentQuestion["wrongAnswer3"], for: .normal)
    
    
    
    //SIMULATION
//    timerReceiveBuzz = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(signalPeerReceiveBuzz), userInfo: nil, repeats: true)
//
//    timerReceiveWrongAnswer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(signalPeerReceiveWrongAnswer), userInfo: nil, repeats: true)
//    //timerReceiveRightAnswer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(signalPeerReceiveRightAnswer), userInfo: nil, repeats: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    syncQuestionBuzzer()  //qui è chiamata solo la prima volta
    AudioSingleton.shared.setAudioShared()
  }
  
  func syncQuestionBuzzer() {
    
    
//    for subUIView in buzzerView.subviews as [UIView] {
//      if subUIView != questionOutlet  {
//        subUIView.removeFromSuperview()
//      }
//    }
    
    
    //if "sono host"
      //preparo e invio la domanda, e il buzzer scelto casualmente
    indexBuzzer = Int(arc4random_uniform(4))  //buzzer random
    //else "sono guest"
      //attendo di ricevere la domanda e il buzzer
    
    setQuestion()
    setBuzzer()
  }
  
  func setQuestion()  {
    questionOutlet.text = question["text"]
    buttonAnswerOne.setTitle(question["wrongAnswer2"], for: .normal)  //TODO: sistemazione casuale delle risposte
    buttonAnswerOne.backgroundColor = UIColor.bottonColorLightBlue()
    
    buttonAnswerTwo.setTitle(question["wrongAnswer3"], for: .normal)
    buttonAnswerTwo.backgroundColor = UIColor.bottonColorLightBlue()
    
    buttonAnswerThree.setTitle(question["correctlyAnswer"], for: .normal)
    buttonAnswerThree.backgroundColor = UIColor.bottonColorLightBlue()
    
    buttonAnswerFour.setTitle(question["wrongAnswer1"], for: .normal)
    buttonAnswerFour.backgroundColor = UIColor.bottonColorLightBlue()
  }
  
  
  // - MARK: 3: Method that loads the progress view
  @objc func loadProgressView30() {
    if let progressView30 = Bundle.main.loadNibNamed("ProgressView", owner: self, options: nil)?.first as? ProgressView {
      progressControllerView.addSubview(progressView30)
      progressView30.manageProgress(seconds: 30)
      progressView30.frame = progressControllerView.bounds
    }
  }
  
  @objc func loadProgressView10() {
    if let progressView10 = Bundle.main.loadNibNamed("ProgressView", owner: self, options: nil)?.first as? ProgressView {
      progressControllerView.addSubview(progressView10)
      progressView10.manageProgress(seconds: 10)
      progressView10.frame = progressControllerView.bounds
    }
  }

  // - MARK: 4: Method that generates random buzzers
  func setBuzzer() {
    if indexBuzzer == 0 {
      if let oneBuzzer = Bundle.main.loadNibNamed("OneBuzzer", owner: self, options: nil)?.first as? OneBuzzer {
        buzzerView.addSubview(oneBuzzer)
        oneBuzzer.loadPopUp(view: view)
        oneBuzzer.setBuzzer()
        oneBuzzer.frame = buzzerView.bounds
        changeBackgroundColor(finalColor: UIColor.orange)
      }
    } else if indexBuzzer == 1 {
      NotificationCenter.default.addObserver(self, selector: #selector(self.moveQuestionBoxToOrigin), name: NSNotification.Name(rawValue: "twoBuzzersException"), object: nil)
      point.x = questionOutlet.center.x
      questionOutlet.center.x = view.bounds.width * 0.465
      if let twoBuzzers = Bundle.main.loadNibNamed("TwoBuzzers", owner: self, options: nil)?.first as? TwoBuzzers {
        buzzerView.addSubview(twoBuzzers)
        twoBuzzers.loadPopUp(view: view)
        twoBuzzers.setBuzzers()
        twoBuzzers.frame = buzzerView.bounds
        changeBackgroundColor(finalColor: backgroundRed)
      }
    } else if indexBuzzer == 2 {
      if let shakeBuzzer = Bundle.main.loadNibNamed("ShakeBuzzer", owner: self, options: nil)?.first as? ShakeBuzzer {
        buzzerView.addSubview(shakeBuzzer)
        shakeBuzzer.loadPopUp()
        shakeBuzzer.setRoundedView()
        shakeBuzzer.setRoundedLabel()
        shakeBuzzer.setIndicatorView()
        shakeBuzzer.frame = buzzerView.bounds
        changeBackgroundColor(finalColor: UIColor.black)
      }
    } else {
      if let blowBuzzer = Bundle.main.loadNibNamed("BlowBuzzer", owner: self, options: nil)?.first as? BlowBuzzer {
        buzzerView.addSubview(blowBuzzer)
        blowBuzzer.loadPopUp()
        blowBuzzer.setRoundedView()
        blowBuzzer.setIndicatorView()
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
    buttonAnswerOne.alpha = 0
    
    buttonAnswerTwo.layer.cornerRadius = 25
    buttonAnswerTwo.layer.borderColor = UIColor.borderColorGray()
    buttonAnswerTwo.layer.borderWidth = 6.0
    buttonAnswerTwo.alpha = 0
      
    buttonAnswerThree.layer.cornerRadius = 25
    buttonAnswerThree.layer.borderColor = UIColor.borderColorGray()
    buttonAnswerThree.layer.borderWidth = 6.0
    buttonAnswerThree.alpha = 0
    
    buttonAnswerFour.layer.cornerRadius = 25
    buttonAnswerFour.layer.borderColor = UIColor.borderColorGray()
    buttonAnswerFour.layer.borderWidth = 6.0
    buttonAnswerFour.alpha = 0
    
    onHoldLabel.layer.cornerRadius = 15.0
    onHoldLabel.clipsToBounds = true
  }
  
  func rightAnswer(button: UIButton)  {
    disableAnswersInteractions()
    audioAnswerRight.player.play()
    button.backgroundColor = .green
    signalPeerSendRightAnswer()
    Singleton.shared.delayWithSeconds(3) {
      self.enableAnswersInteraction()
      self.syncQuestionBuzzer()
      self.answersBlock()
    }
  }
  
  func wrongAnswer(button: UIButton)  {
    disableAnswersInteractions()
    audioAnswerWrong.player.play()
    button.backgroundColor = .red
    signalPeerSendWrongAnswer()
    Singleton.shared.delayWithSeconds(1.5) {
      self.answersBlock()
      self.enableAnswersInteraction()
      self.onHoldLabel.text = "Waiting"
      self.onHoldLabel.isHidden = false
      self.onHoldView.isHidden = false
    }
  }
  
  @IBAction func buttonAnswerOneAction(_ sender: UIButton) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
    if buttonAnswerOne.titleLabel?.text == question["correctlyAnswer"] {
      rightAnswer(button: buttonAnswerOne)
    } else  {
      wrongAnswer(button: buttonAnswerOne)
    }
  }
  
  @IBAction func buttonAnswerTwoAction(_ sender: UIButton) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
    if buttonAnswerTwo.titleLabel?.text == question["correctlyAnswer"] {
      rightAnswer(button: buttonAnswerTwo)
    } else  {
      wrongAnswer(button: buttonAnswerTwo)
    }
  }
  
  @IBAction func buttonAnswerThreeAction(_ sender: UIButton) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
    if buttonAnswerThree.titleLabel?.text == question["correctlyAnswer"] {
      rightAnswer(button: buttonAnswerThree)
    } else  {
      wrongAnswer(button: buttonAnswerThree)
    }
  }
  
  @IBAction func buttonAnswerFourAction(_ sender: UIButton) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
    if buttonAnswerFour.titleLabel?.text == question["correctlyAnswer"] {
      rightAnswer(button: buttonAnswerFour)
    } else  {
      wrongAnswer(button: buttonAnswerFour)
    }
  }
  
  
  /*
  @IBAction func buttonAction(_ sender: UIButton) {
    randomBuzzers()
    buttonAnswerOne.alpha = 0
    buttonAnswerTwo.alpha = 0
    buttonAnswerThree.alpha = 0
    buttonAnswerFour.alpha = 0
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
    Singleton.shared.delayWithSeconds(4) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startTimer"), object: nil)
    }
  }
  */
  func changeBackgroundColor(finalColor: UIColor) {
    view.changeBackgroundColor(initColor: view.backgroundColor!, finalColor: finalColor)
    Singleton.shared.delayWithSeconds(1.8, completion: {
      self.view.backgroundColor = finalColor
    })
  }
  
  
  func peerSendQuestionBuzzer() {
    //TODO: invio domanda e buzzer da parte dell'host
  
  }
  
  func peerReceiveQuestionBuzzer() {
    //TODO: ricezione domanda e buzzer da parte del guest
    
  }
  
  func signalPeerSendBuzz() {
    //TODO: invio multipeer agli altri giocatori della prenotazione
    
  }
  
  func signalPeerSendWrongAnswer() {
    //TODO: invio multipeer agli altri giocatori della risposta sbagliata
  }

  func signalPeerSendRightAnswer() {
    //TODO: invio multipeer agli altri giocatori della risposta esatta
    
  }
  
  @objc func signalPeerReceiveBuzz() {
    timerReceiveBuzz.invalidate()
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopBlowing"), object: nil)
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopShaking"), object: nil)
    //TODO: ricezione multipeer da altro giocatore
    
    onHoldView.isHidden = false
    onHoldLabel.isHidden = false
  }
  
  @objc func signalPeerReceiveWrongAnswer() {
    timerReceiveWrongAnswer.invalidate()
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startTimer"), object: nil)
    //TODO: ricezione multipeer da altro giocatore
    
    onHoldView.isHidden = true
    onHoldLabel.isHidden = true
  }
  
  
  @objc func signalPeerReceiveRightAnswer() {
    timerReceiveRightAnswer.invalidate()
    //TODO: ricezione multipeer da altro giocatore
    Singleton.shared.delayWithSeconds(3) {
      self.syncQuestionBuzzer()
      self.answersBlock()
    }
    onHoldView.isHidden = true
    onHoldLabel.isHidden = true
  }
  
  @objc func moveQuestionBoxToOrigin() {
    questionOutlet.questionBoxMoveLeft(view: view, initPosition: point)
    Singleton.shared.delayWithSeconds(0.4) {
      self.questionOutlet.center.x = self.point.x
    }
  }
  
  @objc func answersAppear() {
    signalPeerSendBuzz()  //invio al peer
    
    self.buttonAnswerOne.fadeInAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.buttonAnswerOne.alpha = 1
    }
    self.buttonAnswerTwo.fadeInAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.buttonAnswerTwo.alpha = 1
    }
    self.buttonAnswerThree.fadeInAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.buttonAnswerThree.alpha = 1
    }
    self.buttonAnswerFour.fadeInAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.buttonAnswerFour.alpha = 1
    }
  }
  
  @objc func answersBlock() {
    self.buttonAnswerOne.fadeOutAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.buttonAnswerOne.alpha = 0
    }
    self.buttonAnswerTwo.fadeOutAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.buttonAnswerTwo.alpha = 0
    }
    self.buttonAnswerThree.fadeOutAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.buttonAnswerThree.alpha = 0
    }
    self.buttonAnswerFour.fadeOutAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.buttonAnswerFour.alpha = 0
    }
  }

  @objc func timeOut() {
    onHoldLabel.text = "Time is Up!"
    onHoldView.isHidden = false
    onHoldLabel.isHidden = false
    Singleton.shared.delayWithSeconds(4) {
      self.syncQuestionBuzzer()
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startTimer"), object: nil)
      self.onHoldView.isHidden = true
      self.onHoldLabel.isHidden = true
      self.onHoldLabel.text = "On Hold..."
    }
    Singleton.shared.delayWithSeconds(5) {
      self.buttonAnswerOne.alpha = 0
      self.buttonAnswerTwo.alpha = 0
      self.buttonAnswerThree.alpha = 0
      self.buttonAnswerFour.alpha = 0
    }
  }
  
  func disableAnswersInteractions() {
    buttonAnswerOne.isUserInteractionEnabled = false
    buttonAnswerTwo.isUserInteractionEnabled = false
    buttonAnswerThree.isUserInteractionEnabled = false
    buttonAnswerFour.isUserInteractionEnabled = false
  }
  
  func enableAnswersInteraction() {
    buttonAnswerOne.isUserInteractionEnabled = true
    buttonAnswerTwo.isUserInteractionEnabled = true
    buttonAnswerThree.isUserInteractionEnabled = true
    buttonAnswerFour.isUserInteractionEnabled = true
  }
}
