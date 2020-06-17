
//
//  GameScene.swift
//  ZombieConga1
//
//  Created by Mervat Mustafa on 2020-06-08.
//  Copyright © 2020 Mervat Mustafa. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
  
  let panda1 = SKSpriteNode(imageNamed: "panda")
 var lastUpdateTime: TimeInterval = 0
  var dt: TimeInterval = 0
  let PandaMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPoint.zero
    var invincible = false
  let playableRect: CGRect
  var lastTouchLocation: CGPoint?
    //let maximumMovePersecond = 80
    var lives = 3
    var coin = 0
    var coinsCollected = 0
    var finalScore = 0
     let scoresLabel = SKLabelNode(fontNamed: "Chalkduster")
    var gameOver = false
    var exit =  false
    
  let labelNode = SKLabelNode(fontNamed: "Chalkduster")
    
  override init(size: CGSize) {
    let maxAspectRatio:CGFloat = 16.0/9.0
    let playableHeight = size.width / maxAspectRatio
    let playableMargin = (size.height-playableHeight)/2.0
    playableRect = CGRect(x: 0, y: playableMargin,
                          width: size.width,
                          height: playableHeight)
    super.init(size: size)
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    
  func debugDrawPlayableArea() {
    let shape = SKShapeNode()
    let path = CGMutablePath()
    path.addRect(playableRect)
    shape.path = path
    shape.strokeColor = SKColor.blue
    shape.lineWidth = 4.0
    addChild(shape)
  }
    

    
    func spawnCoin() {
      // 1
      let cat = SKSpriteNode(imageNamed: "coin2")
      cat.name = "coin"
      cat.position = CGPoint(
        x: playableRect.minX + 700,
        y: playableRect.minY + 90)
      cat.zPosition = 50
      cat.setScale(0)
      addChild(cat)
      // 2
      let appear = SKAction.scale(to: 1.0, duration: 0.5)

      let actions = [appear]
      cat.run(SKAction.sequence(actions))
    }
    
    func spawnSpikes() {
      let spike = SKSpriteNode(imageNamed: "spikes")
        spike.position = CGPoint(x: CGFloat.random(min: playableRect.minX + 190, max: playableRect.maxX - 180),y: 220)
        spike.setScale(1.5)
      addChild(spike)
    }

  override func didMove(to view: SKView) {

    let background = SKSpriteNode(imageNamed: "background")
    background.anchorPoint = .zero// default
    
    background.zPosition = -1
      addChild(background)
    
    let mySize = background.size
       print("Size: \(mySize)")
    
    
     panda1.position = CGPoint(x: 100, y: 150)

    addChild(panda1)
    debugDrawPlayableArea()
    spawnSpikes()
    go()
    
    labelNode.text = "Lives: \(lives)"
    labelNode.fontColor = .black
    labelNode.fontSize = 100
    labelNode.zPosition = 1300
    labelNode.position = CGPoint(x:300,
                                 y:500)
    addChild(labelNode)
    
    }
    
     func go(){

        
            let moveRight = SKAction.move(to: CGPoint(x: playableRect.width, y:  220), duration: 5)

           // let RPL = SKAction.scaleX(to: panda1.xScale * -1, duration: 5)

            let moveLeft = SKAction.move(to: CGPoint(x: 0, y:  220), duration: 5)

           // let RPR = SKAction.scaleX(to: panda1.xScale , duration: 0)



    panda1.run(SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft])))

        }
//
//
//    livesLabel.text = "Lives: X"
//    livesLabel.fontColor = SKColor.black
//    livesLabel.fontSize = 100
//    livesLabel.zPosition = 150
//    livesLabel.horizontalAlignmentMode = .left
//    livesLabel.verticalAlignmentMode = .bottom
//    livesLabel.position = CGPoint(
//        x: -playableRect.size.width/2 + CGFloat(20),
//        y: -playableRect.size.height/2 + CGFloat(20))
//    cameraNode.addChild(livesLabel)
//
//    CoinLabel.text = "Coins: X"
//    CoinLabel.fontColor = SKColor.black
//                   CoinLabel.fontSize = 100
//                  CoinLabel.zPosition = 150
//    CoinLabel.horizontalAlignmentMode = .right
//    CoinLabel.verticalAlignmentMode = .top
//    CoinLabel.position = CGPoint(x: -playableRect.size.width/2 + CGFloat(20),
//                                 y: -playableRect.size.width/2 + CGFloat(20))
//                          cameraNode.addChild(CoinLabel)
//
//
//    run(SKAction.repeatForever(
//    SKAction.sequence([SKAction.run() { [weak self] in
//                        self?.spawnCoin()
//                      },
//                       SKAction.wait(forDuration: 0.5)])))
//
//  }
//
    
    
    
    //this function is mario when it gets hit by enemy
    
    
  
//    func checkCollisions() {
//         var hitCoins: [SKSpriteNode] = []
//        enumerateChildNodes(withName: "coin") { node, _ in
//          let coin = node as! SKSpriteNode
//          if coin.frame.intersects(self.panda1.frame) {
//            hitCoins.append(coin)
//          }
//        }
//        for cat in hitCoins {
//          coinHit(enemy: cat)
//        }
//        var hitEnemies: [SKSpriteNode] = []
//        enumerateChildNodes(withName: "Enemy") { node, _ in
//          let enemy = node as! SKSpriteNode
//          if node.frame.insetBy(dx: 20, dy: 20).intersects(
//            self.panda1.frame) {
//            hitEnemies.append(enemy)
//          }
//        }
//        for enemy in hitEnemies {
//          pandaHit(enemy: enemy)
//        }
//      }
//
    func coinHit(enemy: SKSpriteNode) {


       enemy.removeFromParent()
       coin += 1
        print(coin)

        finalScore = coin

      }
    
    
    
    
    
//
    func sceneTouched(touchLocation:CGPoint) {
    let actionJump : SKAction
        actionJump = SKAction.moveBy(x: 0, y: 500, duration: 1.0)
    let jumpSequence = SKAction.sequence([actionJump, actionJump.reversed()])
    panda1.run(jumpSequence)


    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>,
         with event: UIEvent?) {
       guard let touch = touches.first else {
         return
       }
       let touchLocation = touch.location(in: self)
       sceneTouched(touchLocation: touchLocation)
     }
    
    
  override func update(_ currentTime: TimeInterval) {
  
   // panda1.position = CGPoint(x: panda1.position.x + 8,y: panda1.position.y)
    
    if lastUpdateTime > 0 {
      dt = currentTime - lastUpdateTime
    } else {
      dt = 0
    }
    
    lastUpdateTime = currentTime
    move(sprite: panda1, velocity: velocity)
    boundsCheckPanda()
collideSpike()
    spawnCoin()
    
    
//
//   move(sprite: mario, velocity: velocity)
// moveCamera()
//    livesLabel.text = "Lives: \(lives)"
//    CoinLabel.text = "Coins: \(coin)"
//    checkCollisions()
//
//    if lives <= 0 && !gameOver {
//      gameOver = true
//      print("You lose!")
//        print("Your Final Score is " + String(finalScore))
//      backgroundMusicPlayer.stop()
//
//        let gameOver = GameOverScene(size: size, won: false)
//       // let gameOverScene = Gam(size: size, won: false)
//        //gameOverScene.scaleMode = scaleMode
//        gameOver.scaleMode = scaleMode
//        // 2
//        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
//        // 3
//        view?.presentScene(gameOver, transition: reveal)
//
//    } else if finalScore>=3 {
//
//    let gameOver = GameOverScene(size: size, won: true)
//          // let gameOverScene = Gam(size: size, won: false)
//           //gameOverScene.scaleMode = scaleMode
//           gameOver.scaleMode = scaleMode
//           // 2
//           let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
//           // 3
//           view?.presentScene(gameOver, transition: reveal)
//    }
    }
//    func collisionSpike()
//         {
//             enumerateChildNodes(withName: "spike")
//             {
//                 node, _ in
//                 let spike = node as! SKSpriteNode
//                 if spike.frame.offsetBy(dx: 50, dy: 50).intersects(self.panda1.frame)
//                 {
//                     self.lives -= 1
//                    print(self.lives)
//                     self.labelNode.text = "Lives: \(self.lives)"
//
//                 }
//             }
//         }
    
    func collideSpike()
      {
          var spikes:[SKSpriteNode] = []
          enumerateChildNodes(withName: "spike")
          {
              node, _ in
              let spike = node as! SKSpriteNode
              if spike.frame.insetBy(dx: 30, dy: 30).intersects(self.panda1.frame.insetBy(dx: 20, dy: 20))
              {
                  //self.lastChanged -= 1
                  spikes.append(spike)
                  spike.removeFromParent()
                  self.lives -= 1
                  self.panda1.position = CGPoint(x:100,
                                                      y:150)
                 
               
              }
              
             
          }
          for spike in spikes
          {
              spike.removeFromParent()
               self.spawnSpikes()
              
          }
         
          enumerateChildNodes(withName: "coin")
          {node ,_ in
                       
              let coin = node as! SKSpriteNode
                  if coin.frame.intersects(self.panda1.frame)
              {
                  self.coin += 1
                  coin.removeFromParent()
              }
          
          }
         
          
          enumerateChildNodes(withName: "exit")
          {
              node, _ in
              
              let exit = node as! SKSpriteNode
              if exit.frame.insetBy(dx: 50   , dy: 50).intersects(self.panda1.frame)
              {
                  self.panda1.removeFromParent()
                  
                  let reveal = SKTransition.reveal(with: .up, duration: 1.0)
                 
              }
              
              
          }
      }
    
  
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
       let amountToMove = CGPoint(x: velocity.x * CGFloat(dt),
                                  y: velocity.y * CGFloat(dt))
       print("Amount to move: \(amountToMove)")
       sprite.position += amountToMove
        
     }
    
    
    func boundsCheckPanda() {
        let bottomLeft:CGPoint = CGPoint(x:0,
                                            y:playableRect.minY)
           let topRight:CGPoint = CGPoint(x:size.width,
                                          y:playableRect.maxY)
           if panda1.position.x >= topRight.x
           {
               velocity.x = -velocity.x
           }
           if panda1.position.x <= bottomLeft.x
           {
               velocity.x = -velocity.x
           }
           
     }
   
  
  
    
    
    
}
