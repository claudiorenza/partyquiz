//
//  MainPageViewController.swift
//  Party Quiz Game
//
//  Created by Giovanni Frate on 14/02/18.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import AVFoundation

class MainPageViewController: UIViewController {
  
  @IBOutlet weak var createGameOutlet: UIButton!
  @IBOutlet weak var joinGameOutlet: UIButton!
  @IBOutlet weak var labelOutlet: UILabel!
  
  var audioPlayerButtonClick = AVAudioPlayer()
  var audioPlayerMusic = AVAudioPlayer()
  let borderColor = UIColor(red: 96.0/255.0, green: 96.0/255.0, blue: 96.0/255.0, alpha: 1.0).cgColor
  
  override func viewDidLoad() {
    super.viewDidLoad()
    PeerManager.peerShared.mainVC = self
    PeerManager.peerShared.viewController = self
    PeerManager.peerShared.setupConnection()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setButton(tempButton: createGameOutlet)
    setButton(tempButton: joinGameOutlet)
    
    let audioButtonClick = Bundle.main.path(forResource: "buttonClick", ofType: "m4a")
    let audioIntroMusic = Bundle.main.path(forResource: "musicIntro", ofType: "m4a")
    
    
    // copy this syntax, it tells the compiler what to do when action is received
    do {
      audioPlayerButtonClick = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioButtonClick! ))
      audioPlayerMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioIntroMusic! ))
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
      try AVAudioSession.sharedInstance().setActive(true)
    }
    catch{
      print(error)
    }
    
    audioPlayerMusic.play()
    
    createGameOutlet.entering(directionFrom: "left", view: self.view)
    joinGameOutlet.entering(directionFrom: "right", view: self.view)
  }
  
  
  func setButton(tempButton: UIButton) {
    tempButton.layer.cornerRadius = 25.0
    tempButton.layer.borderColor = UIColor.borderColorGray()
    tempButton.layer.borderWidth = 6.0
  }
  
  @IBAction func pressToCreate(_ sender: UIButton) {
    audioPlayerButtonClick.play()
    audioPlayerMusic.stop()
  }
  
  @IBAction func pressToJoin(_ sender: UIButton) {
    PeerManager.peerShared.stopAdvertiser()
    PeerManager.peerShared.startBrowser()
    PeerManager.peerShared.setupBrowserVC()
    present(PeerManager.peerShared.browserVC, animated: true, completion: nil)
    audioPlayerButtonClick.play()
    audioPlayerMusic.stop()
  }
  
  @IBAction func pressForInfo(_ sender: UIButton) {
    labelOutlet.text = "Infos..."
  }
  
  @IBAction func createGameAction(_ sender: UIButton) {
    createGameOutlet.exit(directionTo: "left", view: view)
    joinGameOutlet.exit(directionTo: "right", view: view)
    Singleton.shared.delayWithSeconds(0.8) {
      self.performSegue(withIdentifier: "fromCreate1", sender: self)
    }
  }
}
