//
//  ViewController.swift
//  SimpleQuestion4Claudio
//
//  Created by Giovanni Frate on 13/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

  @IBOutlet weak var buzzerOutlet: UIButton!
  @IBOutlet weak var questionOutlet: UILabel!
  @IBOutlet weak var backgroundOutlet: UIImageView!
  @IBOutlet weak var viewOutlet: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButton(tempButton: buzzerOutlet)
    setQuestion(tempLabel: questionOutlet)
    backgroundOutlet.layer.cornerRadius = 25.0
    backgroundOutlet.layer.borderColor = UIColor.black.cgColor
    backgroundOutlet.layer.borderWidth = 1.0
  }

  @IBAction func pressBuzzer(_ sender: UIButton) {
    sender.buzzerDown(view: self.view)
    if let answersView = Bundle.main.loadNibNamed("AnswersView", owner: self, options: nil)?.first as? AnswersView {
      
      answersView.frame = viewOutlet.frame
      answersView.setButton(tempButton: answersView.firstAnswer)
      answersView.setButton(tempButton: answersView.secondAnswer)
      answersView.setButton(tempButton: answersView.thirdAnswer)
      answersView.setButton(tempButton: answersView.fourthAnswer)
      
      self.view.addSubview(answersView)
    }
  }
  
  
  func setQuestion(tempLabel: UILabel) {
    tempLabel.text = "This is a new question!!"
  }
  
  func hideAnswers(ans1: UIButton, ans2: UIButton, ans3: UIButton, ans4: UIButton) {
    ans1.isHidden = true
    ans2.isHidden = true
    ans3.isHidden = true
    ans4.isHidden = true
  }
  
  func showAnswers(ans1: UIButton, ans2: UIButton, ans3: UIButton, ans4: UIButton) {
    ans1.isHidden = false
    ans2.isHidden = false
    ans3.isHidden = false
    ans4.isHidden = false
  }
  
  func setButton(tempButton: UIButton) {
    tempButton.layer.cornerRadius = 25.0
    tempButton.layer.borderColor = UIColor.black.cgColor
    tempButton.layer.borderWidth = 1.0
  }

}

