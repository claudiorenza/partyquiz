//
//  GameViewController.swift
//  partyquiz
//
//  Created by Claudio Renza on 08/02/2018.
//  Copyright © 2018 Claudio Renza. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size) 
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
                
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}
