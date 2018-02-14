//
//  MainPageViewController.swift
//  SimpleQuestion4Claudio
//
//  Created by Giovanni Frate on 14/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MainPageViewController: UIViewController, MCBrowserViewControllerDelegate, MCNearbyServiceBrowserDelegate, MCAdvertiserAssistantDelegate {
  
  func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    dismiss(animated: true, completion: nil)
  }
  
  func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    dismiss(animated: true, completion: {
      PeerManager.shared.browser?.stopBrowsingForPeers()
      PeerManager.shared.advertiser?.stop()
    })
  }
  func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
    print("errore \(error)")
  }
  
  func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    print("trovato \(peerID)")
    PeerManager.shared.peerArray.append(peerID)
  }
  
  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    print("perso \(peerID)")
    PeerManager.shared.removePeer(peerID: peerID)
  }
  
 
  
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
    tempButton.layer.borderWidth = 1.0
  }
  
  @IBAction func pressToCreate(_ sender: UIButton) {
    PeerManager.shared.browser?.stopBrowsingForPeers()
    PeerManager.shared.advertiser = MCAdvertiserAssistant(serviceType: PeerManager.shared.service, discoveryInfo: nil, session: PeerManager.shared.session!)
    PeerManager.shared.advertiser?.delegate = self
    PeerManager.shared.advertiser?.start()
    let controller = MCBrowserViewController(serviceType: PeerManager.shared.service, session: PeerManager.shared.session!)
    controller.delegate = self
    present(controller, animated: true, completion: nil)
  }
  
  @IBAction func pressToJoin(_ sender: UIButton) {
    PeerManager.shared.advertiser?.stop()
    PeerManager.shared.session = MCSession(peer: PeerManager.shared.peerID!, securityIdentity: nil, encryptionPreference: .none)
    PeerManager.shared.browser = MCNearbyServiceBrowser(peer: PeerManager.shared.peerID!, serviceType: PeerManager.shared.service)
    PeerManager.shared.browser?.delegate = self
    PeerManager.shared.browser?.startBrowsingForPeers()
    let controller = MCBrowserViewController(serviceType: PeerManager.shared.service, session: PeerManager.shared.session!)
    controller.delegate = self
    present(controller, animated: true, completion: nil)
  }
  
  @IBAction func pressForInfo(_ sender: UIButton) {
    labelOutlet.text = "Infos..."
  }
}
