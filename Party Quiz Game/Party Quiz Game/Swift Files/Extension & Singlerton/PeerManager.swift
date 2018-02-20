//
//  PeerManager.swift
//  Party Quiz Game
//
//  Created by Armando Feniello on 20/02/18.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class PeerManager: NSObject,  MCNearbyServiceBrowserDelegate, MCAdvertiserAssistantDelegate, MCBrowserViewControllerDelegate{
  
  // - MARK: 1: Outlets and Variables
  static let shared = PeerManager()
  var controllerOrigin:UIViewController?
  var peerID: MCPeerID!
  var session: MCSession!
  var browser: MCNearbyServiceBrowser?
  var advertiser: MCAdvertiserAssistant? = nil
  var service = "PartiQuiz"
  var peerArray = [MCPeerID]()
  var browserVC: MCBrowserViewController!
  var firstGame = 1
  var question: String!
  override init(){
    peerID = MCPeerID(displayName: UIDevice.current.name)
    
  }
  func convertData(string: String) -> Data{
    let data = string.data(using: .utf8)
    return data!
  }
  // - MARK: 2: Funzioni sulla sessione
  func setupSession(){
    session = MCSession(peer: peerID!, securityIdentity: nil, encryptionPreference: .none)
    session.delegate = self
  }
  
  func disconnectSession(){
    session?.disconnect()
  }
  
  // - MARK: 3: Funzione che trova i peer
  func setupBrowser(){
    browser = MCNearbyServiceBrowser(peer: peerID!, serviceType: service)
    browser?.delegate = self
  }
  
  // - MARK: 4: Funzioni che avviano e stoppano il browser
  func startBrowser(){
    browser?.startBrowsingForPeers()
  }
  
  func stopBrowser(){
    browser?.stopBrowsingForPeers()
  }
  
  // - MARK: 5: Funzione che crea la stanza
  func setupAdvertise(){
    advertiser = MCAdvertiserAssistant(serviceType: service, discoveryInfo: nil, session: self.session!)
    advertiser?.delegate = self
  }
  
  // - MARK: 6: Funzioni che avviano e stoppano la visibilità del peer
  func startAdvertise(){
    advertiser?.start()
  }
  
  func stopAdvertise(){
    advertiser?.stop()
  }
  
  // - MARK: 7: Rimuove Peer dall'array quando esco dalla sessione
  func removePeer(peerID: MCPeerID){
    var counter = 0
    for index in peerArray{
      if index == peerID{
        peerArray.remove(at: counter)
      }
      counter = counter + 1
    }
  }
  
  // - MARK: 8: Funzioni di delegate del browser
  // Peer persi
  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    NSLog("@%", "lostPeer \(peerID)")
    removePeer(peerID: peerID)
  }
  // Browser non riesce ad avviarsi
  func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
    NSLog("@%", "error \(error)")
  }
  // Peer rilevati
  func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    NSLog("@%", "foundPeer \(peerID)")
    peerArray.append(peerID)
  }
  // Schermata browser non customizzabile
  func setupBrowserController(){
    browserVC = MCBrowserViewController(serviceType: service, session: self.session!)
    browserVC.delegate = self
   }
  
  func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    browserViewController.dismiss(animated: true, completion: {
      self.stopBrowser()
      self.stopAdvertise()
      self.controllerOrigin?.performSegue(withIdentifier: "GameController", sender: nil)
      do{
        try self.session.send(self.convertData(string: "GameController"), toPeers: self.session.connectedPeers, with: .reliable)
        
      }
      catch let error as NSError{
        let ac = UIAlertController(title: "Connection Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.browserVC.present(ac,animated: true, completion: nil)
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
  func sendQuestion(question: String){
    do{
      try self.session.send(convertData(string: question), toPeers: self.session.connectedPeers, with: .reliable)
    }
    catch let error as NSError{
      let ac = UIAlertController(title: "Connection Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      ac.present(ac,animated: true, completion: nil)        }
  }
  
}
extension PeerManager:  MCSessionDelegate{
  
  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    print("prima del dispatch \(firstGame)")
    if firstGame >= 1{
      DispatchQueue.main.async {
          let msg = String(data: data, encoding: String.Encoding.utf8) as String!
         self.browserVC.dismiss(animated: true, completion: {
          self.controllerOrigin?.performSegue(withIdentifier: msg!, sender: nil)
        })
      }
      firstGame = firstGame - 1
      print(self.firstGame)
    }
    else {
      DispatchQueue.main.async {
        self.question = String(data: data, encoding: String.Encoding.utf8) as String!
        print("print \(self.question)")
      }
      
    }
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
