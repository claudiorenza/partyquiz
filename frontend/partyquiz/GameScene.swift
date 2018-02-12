//
//  GameScene.swift
//  partyquiz
//
//  Created by Claudio Renza on 08/02/2018.
//  Copyright © 2018 Claudio Renza. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  var button = ButtonNode()
  
  //let squareNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 200, height: 200))
  
  let logoNode = SKSpriteNode(imageNamed: "logo")
  
  override func didMove(to view: SKView) {
    backgroundColor = .white
    
    logoNode.size = CGSize(width: 1, height: 1)
    logoNode.position = CGPoint(x: frame.midX, y: frame.maxY / 6 * 4)
    print("\(frame.maxY)")
    
    let moveAction = SKAction.scale(to: CGSize(width: 150, height: 150), duration: 1)
    moveAction.timingMode = SKActionTimingMode.easeOut
    logoNode.run(moveAction)
    
    //logoNode.position = CGPoint(x: frame.midX, y: frame.midY)
    addChild(logoNode)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
}

class ButtonNode: SKSpriteNode {
  let button = UIButton()
  
  func createButton(label: String) {
    button.setTitle(label , for: .normal)
    button.setTitleColor(UIColor.black, for: .normal)
    button.backgroundColor = UIColor.lightGray
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 25
    
    button.frame = CGRect(x: 40, y: 40, width: 150, height: 50)
    button.addTarget(self, action: #selector(pressToCreate), for: .touchUpInside)
  }
  
  @IBAction func pressToCreate(sender: UIButton!) {
  }

}
