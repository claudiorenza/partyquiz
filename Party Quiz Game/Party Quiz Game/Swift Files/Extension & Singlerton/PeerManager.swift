//
//  PeerManager.swift
//  Party Quiz Game
//
//  Created by Armando Feniello on 20/02/18.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class PeerManager: NSObject, MCSessionDelegate, MCAdvertiserAssistantDelegate, MCNearbyServiceBrowserDelegate, MCBrowserViewControllerDelegate {
  
  // - MARK: 1: Properties
  static let peerShared = PeerManager()
  var session: MCSession!
  var advertiser: MCAdvertiserAssistant!
  var peerID: MCPeerID!
  var browser: MCNearbyServiceBrowser!
  var browserVC: MCBrowserViewController!
  var service: String = "AbDesigners"
  var miaStringa = "Armanto"
  var viewController: UIViewController!
  
  // - MARK: 2: Custom functions
  func setupConnection() {
    // peerID
    peerID = MCPeerID(displayName: UIDevice.current.name)
    // session
    session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none)
    session.delegate = self
    // advertiser
    advertiser = MCAdvertiserAssistant(serviceType: service, discoveryInfo: nil, session: self.session)
    advertiser.delegate = self
    // browser
    browser = MCNearbyServiceBrowser(peer: peerID, serviceType: service)
    browser.delegate = self
    // browserVC
    browserVC = MCBrowserViewController(serviceType: service, session: self.session)
    browserVC.delegate = self
  }
  
  func startBrowser() {
    browser?.startBrowsingForPeers()
  }
  
  func stopBrowser() {
    browser?.stopBrowsingForPeers()
  }
  
  func startAdvertiser() {
    advertiser.start()
  }
  
  func stopAdvertiser() {
    advertiser.stop()
  }
  
  func convertData(temp: String) -> Data {
    let data = temp.data(using: .utf8)
    return data!
  }
  
  // - MARK: 3: MCBrowserViewControllerDelegate functions
  func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    // Do something when DONE button is pressed
    browserViewController.dismiss(animated: true, completion: {
      self.viewController.performSegue(withIdentifier: "segue", sender: nil)
      do {
        try self.session.send(self.convertData(temp: "segue"), toPeers: self.session.connectedPeers, with: .reliable)
      }
      catch let error as NSError{
        let ac = UIAlertController(title: "Error connection", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.browserVC.present(ac, animated: true, completion: nil)
        print("Error")
      }
    })
    
  }
  func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    // Do something when CANCEL button is pressed
    browserViewController.dismiss(animated: true, completion: {
      self.stopBrowser()
      self.stopAdvertiser()
    })
  }
  
  func sendQuestion(question: String){
    do{
      try self.session.send(convertData(temp: question), toPeers: self.session.connectedPeers, with: .reliable)
      
    }
    catch let error as NSError{
      let ac = UIAlertController(title: "Connection Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      ac.present(ac,animated: true, completion: nil)        }
  }
  
  // - MARK: 4: MCSessionDelegate functions
  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    let message = String(data: data, encoding: .utf8) as String!
    browserVC.dismiss(animated: true, completion: {
      self.viewController.performSegue(withIdentifier: message!, sender: nil)
    })
  }
  func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    
  }
  func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    
  }
  func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    
  }
  func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    
  }
  
  // - MARK: 5: MCAdvertiserAssistantDelegate functions
  func advertiserAssistantWillPresentInvitation(_ advertiserAssistant: MCAdvertiserAssistant) {
    
  }
  func advertiserAssistantDidDismissInvitation(_ advertiserAssistant: MCAdvertiserAssistant) {
    
  }
  
  // - MARK: 6: MCNearbyServiceBrowserDelegate functions
  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    
  }
  func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    
  }
  func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
    
  }
}
