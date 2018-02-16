//
//  JoinGameViewController.swift
//  SimpleQuestion4Claudio
//
//  Created by Claudio Renza on 15/02/2018.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class JoinGameViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MCNearbyServiceBrowserDelegate {
  
  @IBOutlet var table: UITableView!
  
  @IBOutlet var backButton: UIButton!
  
  @IBAction func goPreviousView(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
    table.dataSource = self
    table.delegate = self
    
    backButton.layer.cornerRadius = 10
    
    
    // Do any additional setup after loading the view.
  }
  

  func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
    print("errore \(error)")
  }
  
  func browser(_ browser: MCNearbyServiceBrowser, foundPeer peer: MCPeerID, withDiscoveryInfo info: [String : String]?) {
    print("found peer \(peer)")
    PeerManager.shared.peerArray.append(peer)
    table.reloadData()
  }
  
  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peer: MCPeerID) {
    NSLog("%@", "lostPeer: \(peer)")
    removePeer(peerID: peer)
    table.reloadData()
  }
  
  func removePeer (peerID: MCPeerID){
    var counter: Int = 0
    for index in PeerManager.shared.peerArray {
      if index == peerID{
        PeerManager.shared.peerArray.remove(at: counter)
      }
      counter = counter + 1
    }
  }
  
  func updatePeer(array: [MCPeerID]) -> String {
    var string:String = ""
    for index in array{
      string = index.displayName
    }
    return string+"\n"
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath as IndexPath)
    cell.textLabel!.text = "\(PeerManager.shared.peerArray[indexPath.row].displayName)"
    cell.backgroundColor = UIColor.clear
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return PeerManager.shared.peerArray.count
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    print("Num: \(indexPath.row)")
    print("Value: \(PeerManager.shared.peerArray[indexPath.row])")
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let peerSelect = PeerManager.shared.peerArray[indexPath.row] as MCPeerID
    PeerManager.shared.browser?.invitePeer(peerSelect, to: PeerManager.shared.session!, withContext: nil, timeout: 20)
    performSegue(withIdentifier: "LobbyController", sender: nil)
  }
  
  var myPeerID = PeerManager.shared.peerID
  
  
  deinit {
    PeerManager.shared.browser?.stopBrowsingForPeers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    PeerManager.shared.advertiser?.stop()
    PeerManager.shared.session = MCSession(peer: PeerManager.shared.peerID!, securityIdentity: nil, encryptionPreference: .none)
    PeerManager.shared.browser = MCNearbyServiceBrowser(peer: PeerManager.shared.peerID!, serviceType: PeerManager.shared.service)
    PeerManager.shared.browser?.delegate = self
    PeerManager.shared.browser?.startBrowsingForPeers()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */


}
