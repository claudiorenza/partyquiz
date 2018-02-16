//
//  PeerManager.swift
//  SimpleQuestion4Claudio
//
//  Created by Giovanni Frate on 14/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class PeerManager: NSObject,  MCNearbyServiceBrowserDelegate, MCAdvertiserAssistantDelegate,MCBrowserViewControllerDelegate{
  
  static let shared = PeerManager()
  var controllerOrigin:UIViewController?
  var con = QuestionViewController()
  var peerID: MCPeerID!
  var session: MCSession!
  var browser: MCNearbyServiceBrowser?
  var advertiser: MCAdvertiserAssistant? = nil
  var service = "game"
  var peerArray = [MCPeerID]()
  var controller: MCBrowserViewController!
  override init(){
    peerID = MCPeerID(displayName: UIDevice.current.name)
    
  }
  func setupSession(){
    session = MCSession(peer: peerID!, securityIdentity: nil, encryptionPreference: .none)
    session.delegate = self
  }
  
  func disconnectSession(){
    session?.disconnect()
  }
  
  func setupBrowser(){
    browser = MCNearbyServiceBrowser(peer: peerID!, serviceType: service)
    browser?.delegate = self
  }
  
  func startBrowser(){
    browser?.startBrowsingForPeers()
  }
  
  func stopBrowser(){
    browser?.stopBrowsingForPeers()
  }
  
  func setupAdvertise(){
    advertiser = MCAdvertiserAssistant(serviceType: service, discoveryInfo: nil, session: self.session!)
    advertiser?.delegate = self
  }
  
  func startAdvertise(){
    advertiser?.start()
  }
  
  func stopAdvertise(){
    advertiser?.stop()
  }
  
  func removePeer(peerID: MCPeerID){
    var counter = 0
    for index in peerArray{
      if index == peerID{
        peerArray.remove(at: counter)
      }
      counter = counter + 1
    }
  }
  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    NSLog("@%", "lostPeer \(peerID)")
    removePeer(peerID: peerID)
  }
  func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
    NSLog("@%", "error \(error)")
  }
  func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    NSLog("@%", "foundPeer \(peerID)")
    peerArray.append(peerID)
  }
  func setupBrowserController(){
    controller = MCBrowserViewController(serviceType: service, session: self.session!)
    controller.delegate = self
    
  }
  
  func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    browserViewController.dismiss(animated: true, completion: {
      self.stopBrowser()
      self.stopAdvertise()
      self.controllerOrigin?.performSegue(withIdentifier: "GameController", sender: nil)
      let msg = "GameController".data(using: .utf8)!
      do{
        try self.session.send(msg, toPeers: self.session.connectedPeers, with: .reliable)
      }
      catch{
        
      }
    })
  }
  
  func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    browserViewController.dismiss(animated: true, completion: {
      self.disconnectSession()
      self.stopBrowser()
      self.stopAdvertise()
    })
  }
  
}
extension PeerManager:  MCSessionDelegate{
  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    print("ricevuto")
    let questionController = QuestionViewController()
    let msg = String(data: data, encoding: String.Encoding.utf8) as String!
    controller.dismiss(animated: true, completion: {
      self.controllerOrigin?.performSegue(withIdentifier: msg!, sender: nil)
    })
    
    
  }
  func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    switch  state {
    case MCSessionState.notConnected:
      print("not connected")
    case MCSessionState.connecting:
      print("connecting")
      
    case MCSessionState.connected:
      print("\n\nconnected\n\n")
    }
  }
  func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    
  }
  func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    
    
  }
  func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    
  }
  
  
}



