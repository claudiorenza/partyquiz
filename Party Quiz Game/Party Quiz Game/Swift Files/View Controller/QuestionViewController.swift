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
  @IBOutlet var buzzerView: UIView!
  @IBOutlet var progressControllerView: UIView!
  @IBOutlet var questionOutlet: UILabel!
  @IBOutlet var answerOneButton: UIButton!
  @IBOutlet var answerTwoButton: UIButton!
  @IBOutlet var answerThreeButton: UIButton!
  @IBOutlet var answerFourButton: UIButton!
  @IBOutlet var onHoldView: UIView!
  @IBOutlet var onHoldLabel: UILabel!
  @IBOutlet var onHoldWaiting: UILabel!
  @IBOutlet var displayTimeLabel: UILabel!
  
  
  var audioAnswerRight = Audio(fileName: "answerRight", typeName: "m4a")
  var audioAnswerWrong = Audio(fileName: "answerWrong", typeName: "m4a")
  var audioTimeUp = Audio(fileName: "timeUp", typeName: "m4a")
  
  
  var timerReceiveWinnerTimer: Timer!        //SIMULATION
  var timerReceiveWrongAnswer: Timer! //SIMULATION
  var timerReceiveRightAnswer: Timer! //SIMULATION
  
  let backgoundBlueOcean = UIColor(red: 67/255, green: 59/255, blue: 240/255, alpha: 1)
  let backgoundLilla = UIColor(red: 189/255, green: 16/255, blue: 224/255, alpha: 1)
  let backgroundRed = UIColor(red: 243/255, green: 75/255, blue: 75/255, alpha: 1)

  var indexBuzzer = 0
  var point = CGPoint()
  var pointTimer = CGPoint()
  
  
  /*
  // JOHNNY'S ZONE
   
  var question: [String:String] = ["text": PeerManager.peerShared.question, "correctlyAnswer": PeerManager.peerShared.correct, "wrongAnswer1": PeerManager.peerShared.wrong1, "wrongAnswer2": PeerManager.peerShared.wrong2, "wrongAnswer3": PeerManager.peerShared.wrong3]
  
  // END OF JOHNNY'S ZONE
   */
  
  var questionLocal: [String:String] = ["text": "Italy's Capital", "correctlyAnswer": "Rome", "wrongAnswer1": "Florence", "wrongAnswer2": "Turin", "wrongAnswer3": "Naples"]
  
  // - MARK: 2: ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = backgoundBlueOcean
    setAnswersQuestion()
    //NotificationCenter.default.addObserver(self, selector: #selector(self.loadProgressView30), name: NSNotification.Name(rawValue: "loadProgressView30"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.loadProgressView10), name: NSNotification.Name(rawValue: "loadProgressView10"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.timeOut), name: NSNotification.Name(rawValue: "timeOut"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.buzzerPressed), name: NSNotification.Name(rawValue: "buzzer"), object: nil)
    
    
    /*
    // CLOUDKIT ZONE
     
    let currentQuestion = CoreDataManager.shared.questionDictionary[0]
    questionOutlet.text = currentQuestion["text"]
    answerOneButton.setTitle(currentQuestion["wrongAnswer1"], for: .normal)
    answerTwoButton.setTitle(currentQuestion["wrongAnswer2"], for: .normal)
    answerThreeButton.setTitle(currentQuestion["correctlyAnswer"], for: .normal)
    answerFourButton.setTitle(currentQuestion["wrongAnswer3"], for: .normal)
     
    // END OF CLOUDKIT ZONE
    */
    
    
    questionOutlet.text = questionLocal["text"]
    answerOneButton.setTitle(questionLocal["wrongAnswer1"], for: .normal)
    answerTwoButton.setTitle(questionLocal["wrongAnswer2"], for: .normal)
    answerThreeButton.setTitle(questionLocal["correctlyAnswer"], for: .normal)
    answerFourButton.setTitle(questionLocal["wrongAnswer3"], for: .normal)
    
    //SIMULATION
//    timerReceiveWinnerTimer = Timer.scheduledTimer(timeInterval: 13, target: self, selector: #selector(signalPeerReceiveWinnerTimer), userInfo: nil, repeats: true)
//
//    timerReceiveWrongAnswer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(signalPeerReceiveWrongAnswer), userInfo: nil, repeats: true)
//    //timerReceiveRightAnswer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(signalPeerReceiveRightAnswer), userInfo: nil, repeats: true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    syncQuestionBuzzer()  //qui è chiamata solo la prima volta
    AudioSingleton.shared.setAudioShared()
  }
  
  func syncQuestionBuzzer() {
    timerReceiveWinnerTimer = Timer.scheduledTimer(timeInterval: 13, target: self, selector: #selector(signalPeerReceiveWinnerTimer), userInfo: nil, repeats: true) //SIMULATION
    
    //if "sono host"
      //preparo e invio la domanda, e il buzzer scelto casualmente
    indexBuzzer = Int(arc4random_uniform(4))  //buzzer random
    //else "sono guest"
      //attendo di ricevere la domanda e il buzzer
    
    displayTimeLabel.isHidden = false
    answersDisappear()
    
    setQuestion()
    setBuzzer()
  }
  
  //TODO: sistemazione casuale delle risposte
  func setQuestion()  {
    questionOutlet.text = questionLocal["text"]
    answerOneButton.setTitle(questionLocal["wrongAnswer2"], for: .normal)
    answerOneButton.backgroundColor = UIColor.bottonColorLightBlue()
    
    answerTwoButton.setTitle(questionLocal["wrongAnswer3"], for: .normal)
    answerTwoButton.backgroundColor = UIColor.bottonColorLightBlue()
    
    answerThreeButton.setTitle(questionLocal["correctlyAnswer"], for: .normal)
    answerThreeButton.backgroundColor = UIColor.bottonColorLightBlue()
    
    answerFourButton.setTitle(questionLocal["wrongAnswer1"], for: .normal)
    answerFourButton.backgroundColor = UIColor.bottonColorLightBlue()
  }
  
  
  // - MARK: 3: Method that loads the progress view
  /*
  @objc func loadProgressView30() {
    if let progressView30 = Bundle.main.loadNibNamed("ProgressView", owner: self, options: nil)?.first as? ProgressView {
      progressControllerView.addSubview(progressView30)
      progressView30.manageProgress(seconds: 30)
      progressView30.frame = progressControllerView.bounds
    }
  }
  */
  @objc func loadProgressView10() {
    //reset timers
    seconds = 0
    fraction = 0
    buzzerTimerStart()
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
      pointTimer.x = displayTimeLabel.center.x
      questionOutlet.center.x = view.bounds.width * 0.465
      displayTimeLabel.center.x = view.bounds.width * 0.465
      
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
    
    answerOneButton.layer.cornerRadius = 25
    answerOneButton.layer.borderColor = UIColor.borderColorGray()
    answerOneButton.layer.borderWidth = 6.0
    answerOneButton.alpha = 0
    
    answerTwoButton.layer.cornerRadius = 25
    answerTwoButton.layer.borderColor = UIColor.borderColorGray()
    answerTwoButton.layer.borderWidth = 6.0
    answerTwoButton.alpha = 0
      
    answerThreeButton.layer.cornerRadius = 25
    answerThreeButton.layer.borderColor = UIColor.borderColorGray()
    answerThreeButton.layer.borderWidth = 6.0
    answerThreeButton.alpha = 0
    
    answerFourButton.layer.cornerRadius = 25
    answerFourButton.layer.borderColor = UIColor.borderColorGray()
    answerFourButton.layer.borderWidth = 6.0
    answerFourButton.alpha = 0
    
    onHoldLabel.layer.cornerRadius = 15.0
    onHoldLabel.clipsToBounds = true
    
    onHoldWaiting.layer.cornerRadius = 15.0
    onHoldWaiting.clipsToBounds = true
  }
  
  func rightAnswer(button: UIButton)  {
    disableAnswersInteractions()
    audioAnswerRight.player.play()
    button.backgroundColor = .green
    //signalPeerSendRightAnswer()
    Singleton.shared.delayWithSeconds(3) {
      self.enableAnswersInteraction()
      self.syncQuestionBuzzer()
      //self.answersDisappear()
    }
  }
  
  func wrongAnswer(button: UIButton)  {
    disableAnswersInteractions()
    audioAnswerWrong.player.play()
    button.backgroundColor = .red
    //signalPeerSendWrongAnswer()
    Singleton.shared.delayWithSeconds(1.5) {
      //self.answersDisappear()
      self.enableAnswersInteraction()
      self.syncQuestionBuzzer()
      //self.onHoldLabel.text = "Waiting"
      //self.onHoldLabel.isHidden = false
      
    }
  }
  
  @IBAction func answerOneButtonAction(_ sender: UIButton) {
    buzzerTimerStop()
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
    if answerOneButton.titleLabel?.text == questionLocal["correctlyAnswer"] {
      rightAnswer(button: answerOneButton)
    } else  {
      wrongAnswer(button: answerOneButton)
    }
  }
  
  @IBAction func answerTwoButtonAction(_ sender: UIButton) {
    buzzerTimerStop()
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
    if answerTwoButton.titleLabel?.text == questionLocal["correctlyAnswer"] {
      rightAnswer(button: answerTwoButton)
    } else  {
      wrongAnswer(button: answerTwoButton)
    }
  }
  
  @IBAction func answerThreeButtonAction(_ sender: UIButton) {
    buzzerTimerStop()
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
    if answerThreeButton.titleLabel?.text == questionLocal["correctlyAnswer"] {
      rightAnswer(button: answerThreeButton)
    } else  {
      wrongAnswer(button: answerThreeButton)
    }
  }
  
  @IBAction func answerFourButtonAction(_ sender: UIButton) {
    buzzerTimerStop()
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopTimer"), object: nil)
    if answerFourButton.titleLabel?.text == questionLocal["correctlyAnswer"] {
      rightAnswer(button: answerFourButton)
    } else  {
      wrongAnswer(button: answerFourButton)
    }
  }
  
  
  /*
  @IBAction func buttonAction(_ sender: UIButton) {
    randomBuzzers()
    answerOneButton.alpha = 0
    answerTwoButton.alpha = 0
    answerThreeButton.alpha = 0
    answerFourButton.alpha = 0
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
    //TODO: invio all'host del tempo di risposta
    let timer = (seconds * 100) + fraction
    print("TIMER: \(timer)")
  }
  
  /*
  func signalPeerSendWrongAnswer() {
    //TODO: invio multipeer agli altri giocatori della risposta sbagliata
  }

  func signalPeerSendRightAnswer() {
    //TODO: invio multipeer agli altri giocatori della risposta esatta
    
  }
  */
  
  
  
  @objc func signalPeerReceiveWinnerTimer() {
    timerReceiveWinnerTimer.invalidate()
    //TODO: ricezione multipeer vincitore miglior timer da host
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "winnerTimer"), object: nil)
    
    answersAppear()
    
    onHoldView.isHidden = true
    onHoldLabel.isHidden = true
    onHoldWaiting.isHidden = true
  }
  
  /*
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
      self.answersDisappear()
    }
    onHoldView.isHidden = true
    onHoldLabel.isHidden = true
  }
  */
  
  @objc func moveQuestionBoxToOrigin() {
    questionOutlet.questionBoxMoveLeft(view: view, initPosition: point)
    displayTimeLabel.questionBoxMoveLeft(view: view, initPosition: pointTimer)
    Singleton.shared.delayWithSeconds(0.4) {
      self.questionOutlet.center.x = self.point.x
      self.displayTimeLabel.center.x = self.pointTimer.x
    }
  }
  
  @objc func buzzerPressed()  {
    buzzerTimerStop()
    onHoldView.isHidden = false
    onHoldLabel.isHidden = false
    onHoldWaiting.isHidden = false
    displayTimeLabel.isHidden = true
    signalPeerSendBuzz()  //invio al peer
  }
  
  @objc func answersAppear() {
    self.answerOneButton.fadeInAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.answerOneButton.alpha = 1
    }
    self.answerTwoButton.fadeInAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.answerTwoButton.alpha = 1
    }
    self.answerThreeButton.fadeInAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.answerThreeButton.alpha = 1
    }
    self.answerFourButton.fadeInAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.answerFourButton.alpha = 1
    }
  }
  
  
  @objc func answersDisappear() {
    self.answerOneButton.fadeOutAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.answerOneButton.alpha = 0
    }
    self.answerTwoButton.fadeOutAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.answerTwoButton.alpha = 0
    }
    self.answerThreeButton.fadeOutAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.answerThreeButton.alpha = 0
    }
    self.answerFourButton.fadeOutAnswers()
    Singleton.shared.delayWithSeconds(0.2) {
      self.answerFourButton.alpha = 0
    }
  }
  
  
  @objc func timeOut() {
    buzzerTimerStop()
    signalPeerSendBuzz()
    timerReceiveWinnerTimer.invalidate()  //SIMULATION
    audioTimeUp.player.play()
    onHoldLabel.text = "Time is Up!"
    onHoldLabel.backgroundColor = .red
    onHoldView.isHidden = false
    onHoldLabel.isHidden = false
    onHoldWaiting.isHidden = false
    Singleton.shared.delayWithSeconds(4) {
      self.syncQuestionBuzzer()
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startTimer"), object: nil)
      self.onHoldView.isHidden = true
      self.onHoldLabel.isHidden = true
      self.onHoldWaiting.isHidden = true
      //self.onHoldLabel.text = "On Hold..."
    }
    Singleton.shared.delayWithSeconds(5) {  //TODO: forse non c'è bisogno
      self.answerOneButton.alpha = 0
      self.answerTwoButton.alpha = 0
      self.answerThreeButton.alpha = 0
      self.answerFourButton.alpha = 0
    }
  }
  
  func disableAnswersInteractions() {
    answerOneButton.isUserInteractionEnabled = false
    answerTwoButton.isUserInteractionEnabled = false
    answerThreeButton.isUserInteractionEnabled = false
    answerFourButton.isUserInteractionEnabled = false
  }
  
  func enableAnswersInteraction() {
    answerOneButton.isUserInteractionEnabled = true
    answerTwoButton.isUserInteractionEnabled = true
    answerThreeButton.isUserInteractionEnabled = true
    answerFourButton.isUserInteractionEnabled = true
  }
  
  //TIMER ZONE
  var startTime = TimeInterval()
  
  var timer:Timer = Timer()
  var seconds: Int!
  var fraction: Int!
  
  func buzzerTimerStart() {
    if (!timer.isValid) {
      let aSelector : Selector = #selector(QuestionViewController.buzzerUpdateTime)
      timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
      startTime = NSDate.timeIntervalSinceReferenceDate
    }
  }
  
  func buzzerTimerStop() {
      timer.invalidate()
      displayTimeLabel.isHidden = true
      onHoldLabel.text = displayTimeLabel.text
    }
  
  @objc func buzzerUpdateTime() {
    let currentTime = NSDate.timeIntervalSinceReferenceDate
    
    //find the difference between current time and start time
    var elapsedTime: TimeInterval = currentTime - startTime
    
    //calculate the seconds in elapsed time
    seconds = Int(elapsedTime)
    elapsedTime -= TimeInterval(seconds)
    
    //find out the fraction of milliseconds to be displayed
    fraction = Int(elapsedTime * 100)
    
    //add the leading zero for minutes, seconds and millseconds and store them as string constants
    let strSeconds = String(format: "%02d", seconds)
    let strFraction = String(format: "%02d", fraction)
    
    //concatenate minuets, seconds and milliseconds as assign it to the UILabel
    displayTimeLabel.text = "\(strSeconds):\(strFraction)"
  }
  
  //END OF TIMER ZONE
}
