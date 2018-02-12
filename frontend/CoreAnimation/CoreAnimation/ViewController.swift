//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Claudio Renza on 12/02/2018.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var buttonCreate: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    buttonCreate.entering()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

