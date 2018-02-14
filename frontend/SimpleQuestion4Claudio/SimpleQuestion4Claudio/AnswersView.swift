//
//  AnswersView.swift
//  SimpleQuestion4Claudio
//
//  Created by Giovanni Frate on 14/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit

class AnswersView: UIView {

  @IBOutlet weak var firstAnswer: UIButton!
  @IBOutlet weak var secondAnswer: UIButton!
  @IBOutlet weak var thirdAnswer: UIButton!
  @IBOutlet weak var fourthAnswer: UIButton!
  
  func setButton(tempButton: UIButton) {
    tempButton.layer.cornerRadius = 25.0
    tempButton.layer.borderColor = UIColor.black.cgColor
    tempButton.layer.borderWidth = 1.0
  }
}
