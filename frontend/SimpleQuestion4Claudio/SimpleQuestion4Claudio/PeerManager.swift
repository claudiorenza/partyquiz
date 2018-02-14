//
//  PeerManager.swift
//  SimpleQuestion4Claudio
//
//  Created by Giovanni Frate on 14/02/18.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class PeerManager: NSObject{
  
  static let shared = PeerManager()
  var peerID: MCPeerID?
  var session: MCSession?
  var browser: MCNearbyServiceBrowser?
  var advertiser: MCAdvertiserAssistant?
  var service = "game"
  var peerArray = [MCPeerID]()
  override init(){
    peerID = MCPeerID(displayName: UIDevice.current.name)
    session = MCSession(peer: peerID!, securityIdentity: nil, encryptionPreference: .none)
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
  
}
