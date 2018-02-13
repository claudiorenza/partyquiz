//
//  ViewController.swift
//  CoreAnimation
//
//  Created by Claudio Renza on 12/02/2018.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mainMenuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mainMenuView = Bundle.main.loadNibNamed("MainMenuView", owner: self, options: nil)?.first as? MainMenuView {
          view.addSubview(mainMenuView)
        }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
      }


}

