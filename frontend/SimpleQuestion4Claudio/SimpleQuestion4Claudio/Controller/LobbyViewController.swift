//
//  LobbyViewController.swift
//  SimpleQuestion4Claudio
//
//  Created by Claudio Renza on 15/02/2018.
//  Copyright © 2018 Giovanni Frate. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class LobbyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MCNearbyServiceAdvertiserDelegate, MCAdvertiserAssistantDelegate, MCBrowserViewControllerDelegate   {
  
  @IBOutlet var table: UITableView!
  
  var idHost: Int!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTable), userInfo: nil, repeats: true)
    table.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
    table.dataSource = self
    table.delegate = self
    
    
    
    // Do any additional setup after loading the view.
    
  }
  
  
  func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    dismiss(animated: true, completion: {
      PeerManager.shared.advertiser?.stop()
      PeerManager.shared.browser?.stopBrowsingForPeers()
      self.performSegue(withIdentifier: "GameController", sender: nil)
      print("hooooola\(String(describing: PeerManager.shared.session?.connectedPeers))")
      
    })
  }
  
  func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    dismiss(animated: true, completion: {
      PeerManager.shared.session?.disconnect()
      PeerManager.shared.advertiser?.stop()
      self.performSegue(withIdentifier: "CreateGame", sender: nil)
    })
  }
  
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath as IndexPath)
    
    
    cell.textLabel!.text = "\(String(describing: PeerManager.shared.peerArray[indexPath.row].displayName))"
    cell.backgroundColor = UIColor.clear
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("hola \(PeerManager.shared.peerArray.count)")
    return PeerManager.shared.peerArray.count
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    print("Num: \(indexPath.row)")
    print("Value: \(String(describing: PeerManager.shared.peerArray[indexPath.row]))")
  }
  
  
  func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    
  }
  
  @objc func updateTable(){
    table.reloadData()
  }
  
  deinit{
    PeerManager.shared.advertiser?.stop()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    PeerManager.shared.browser?.stopBrowsingForPeers()
    PeerManager.shared.advertiser =  MCAdvertiserAssistant(serviceType: PeerManager.shared.service, discoveryInfo: nil, session: PeerManager.shared.session! )
    PeerManager.shared.advertiser?.delegate = self
    PeerManager.shared.advertiser?.start()
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
