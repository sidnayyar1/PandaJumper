//
//  GameOverScene.swift
//  ZombieConga1
//
//  Created by Mervat Mustafa on 2020-06-12.
//  Copyright © 2020 Mervat Mustafa. All rights reserved.
//

import Foundation
import SpriteKit
class GameOverScene: SKScene {
    let won:Bool
init(size: CGSize, won: Bool) {
self.won = won
super.init(size: size)
}
required init(coder aDecoder: NSCoder) {
fatalError("init(coder:) has not been implemented")
}
    
    override func didMove(to view: SKView) {
var background: SKSpriteNode
if (won) {
background = SKSpriteNode(imageNamed: "win")
run(SKAction.playSoundFileNamed("win.png",
waitForCompletion: false))
} else
{
    background = SKSpriteNode(imageNamed: "lose")
run(SKAction.playSoundFileNamed("lose.png",
waitForCompletion: false))
        }
background.position =
CGPoint(x: size.width/2, y: size.height/2)
self.addChild(background)
        
let wait = SKAction.wait(forDuration: 3.0)
let block = SKAction.run {
let myScene = GameScene(size: self.size)
myScene.scaleMode = self.scaleMode
    let reveal = SKTransition.flipHorizontal(withDuration: 1.0)
self.view?.presentScene(myScene, transition: reveal)
}
self.run(SKAction.sequence([wait, block]))
}
}

