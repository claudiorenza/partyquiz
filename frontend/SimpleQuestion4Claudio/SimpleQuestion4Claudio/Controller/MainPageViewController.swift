//
//  MainPageViewController.swift
//  SimpleQuestion4Claudio
//
//  Created by Giovanni Frate on 14/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MainPageViewController: UIViewController {
  
  @IBOutlet weak var createGameOutlet: UIButton!
  @IBOutlet weak var joinGameOutlet: UIButton!
  @IBOutlet weak var labelOutlet: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setButton(tempButton: createGameOutlet)
    setButton(tempButton: joinGameOutlet)
    createGameOutlet.entering(directionFrom: "left", view: self.view)
    joinGameOutlet.entering(directionFrom: "right", view: self.view)
  }
  
  
  func setButton(tempButton: UIButton) {
    tempButton.layer.cornerRadius = 25.0
    tempButton.layer.borderColor = UIColor.white.cgColor
    tempButton.layer.borderWidth = 10.0
  }
  
  @IBAction func pressToCreate(_ sender: UIButton) {
    PeerManager.shared.stopBrowser()
    PeerManager.shared.setupAdvertise()
    PeerManager.shared.startAdvertise()
    PeerManager.shared.setupBrowserController()
    present(PeerManager.shared.controller, animated: true, completion: nil)
  }
  
  @IBAction func pressToJoin(_ sender: UIButton) {
    PeerManager.shared.stopAdvertise()
    PeerManager.shared.setupSession()
    PeerManager.shared.setupBrowser()
    PeerManager.shared.setupBrowserController()
    present(PeerManager.shared.controller, animated: true, completion: nil)
  }
  
  @IBAction func pressForInfo(_ sender: UIButton) {
    labelOutlet.text = "Infos..."
  }
}
