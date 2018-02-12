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
    @IBOutlet weak var buttonJoin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        buttonCreate.entering(directionFrom: "left", view: self.view)
        buttonJoin.entering(directionFrom: "right", view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
      }


}

