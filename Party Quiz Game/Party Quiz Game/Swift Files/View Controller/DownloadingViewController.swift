//
//  DownloadingViewController.swift
//  Party Quiz Game
//
//  Created by Ernesto De Crecchio on 14/02/18.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit
import CloudKit

class DownloadingViewController: UIViewController {
  
  var cloudKitDatabase = CloudKitQuestions.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cloudKitDatabase.questioningDelegate = self
  }
  
  var loadingView: UIView?
  
  override func viewDidAppear(_ animated: Bool) {
    cloudKitDatabase.resetLocalArray()
    //Make loading view
    self.loadingView = UIView(frame: self.view.frame)
    loadingView!.alpha = 0.2
    loadingView!.backgroundColor = UIColor.black
    self.view.addSubview(loadingView!)

    cloudKitDatabase.downloadAllQuestions()
  }
  
  func downloadEnded() {
    self.loadingView?.removeFromSuperview()
    performSegue(withIdentifier: "afterDownload", sender: nil)
  }
  
  
}
