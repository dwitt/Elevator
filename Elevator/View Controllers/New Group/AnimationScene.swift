//
//  AnimationScene.swift
//  Elevator
//
//  Created by David Witt on 2018-07-12.
//  Copyright © 2018 David Witt. All rights reserved.
//

import UIKit
import SpriteKit

class AnimationScene: SKScene {
  
  override func didMove(to view: SKView) {
    self.backgroundColor = UIColor(red: 0.776, green: 0.125, blue: 0.243, alpha: 1.0)
    
    let background = SKSpriteNode(imageNamed: "App.png")
    background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
    background.position = CGPoint(x: 0 , y: -185)
    //background.blendMode = .replace
    addChild(background)
    
    let oval = SKSpriteNode(imageNamed: "Oval.png")
    oval.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    oval.position = CGPoint(x: 0 - oval.size.width/2, y: 0 - oval.size.height / 2)
    oval.alpha = 0.5
    addChild(oval)
    
    let help = SKTexture(imageNamed: "Help.png")
    let ball = SKTexture(imageNamed: "Oval.png")
    
    let moveNodeToCentre = SKAction.move(to: CGPoint(x: 165, y: 230), duration: 1.5)
    let zoom = SKAction.scale(to: 1.2, duration: 0.25)
    let pause = SKAction.wait(forDuration: 1.25)
    let pause1 = SKAction.wait(forDuration: 3)
    let moveToStart = SKAction.move(to: CGPoint(x: 0 - oval.size.width/2, y: 0 - oval.size.height / 2), duration: 0)
    let unZoom = SKAction.scale(to: 1.0, duration: 0)


    

    
    let hide = SKAction.hide()
    let unhide = SKAction.unhide()
    let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.25)
    let fadeOut = SKAction.fadeAlpha(to: 0.5, duration: 0)
    let shrink = SKAction.scale(to: 0.9, duration: 0.15)

    let changeToAlert = SKAction.setTexture(help, resize: true)
    let changeToBall = SKAction.setTexture(ball, resize: true)
    
    let press = SKAction.group([zoom, fadeIn])
    
    let reset = SKAction.group([hide, changeToBall, fadeOut, moveToStart, unZoom])
    
    let sequence = SKAction.sequence([unhide,moveNodeToCentre, press, pause, changeToAlert, shrink, pause1, reset])
    
    let repeatForever = SKAction.repeatForever(sequence)
    
    oval.run(repeatForever)
    
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
  }
  
}
