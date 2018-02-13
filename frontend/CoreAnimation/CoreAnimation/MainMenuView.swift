//
//  MainMenuView.swift
//  CoreAnimation
//
//  Created by Claudio Renza on 13/02/2018.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit

class MainMenuView: UIView {

  @IBOutlet var buttonCreate: UIButton!
  
  @IBOutlet var buttonJoin: UIButton!
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    enterButtons()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    enterButtons()
  }
  
  
  public func enterButtons()  {
    print("View caricata")
    buttonCreate.entering(directionFrom: "left", view: self)
    buttonJoin.entering(directionFrom: "right", view: self)
  }
}
