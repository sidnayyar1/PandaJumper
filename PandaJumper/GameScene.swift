

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

    // this function created a rectangle shape
  func debugDrawPlayableArea() {
    let shape = SKShapeNode()
    let path = CGMutablePath()
    path.addRect(playableRect)
    shape.path = path
    shape.strokeColor = SKColor.blue
    shape.lineWidth = 4.0
    addChild(shape)
  }
    

    // this function
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

    func coinHit(enemy: SKSpriteNode) {

       enemy.removeFromParent()
       coin += 1
        print(coin)

        finalScore = coin

      }
    
    
    func sceneTouched(touchLocation:CGPoint) {
    let actionJump : SKAction
        actionJump = SKAction.moveBy(x: 0, y: 500, duration: 1.0)
    let jumpSequence = SKAction.sequence([actionJump, actionJump.reversed()])
    panda1.run(jumpSequence)


    }
    
    
    
//this fucntion is to exit from the game
    func spawnExit() {
         let exit = SKSpriteNode(imageNamed: "exit")
         exit.name = "exit"
         exit.position = CGPoint(
           x: playableRect.maxX-100,
           y: playableRect.minY + 100)
         exit.zPosition = 50
         exit.setScale(0)
         addChild(exit)
         // 2
         let appear = SKAction.scale(to: 1.0, duration: 0.5)

         let actions = [appear]
         exit.run(SKAction.sequence(actions))
       }
    
    
    // this function is to touch the panda and make it jump
    
    override func touchesBegan(_ touches: Set<UITouch>,
         with event: UIEvent?) {
       guard let touch = touches.first else {
         return
       }
       let touchLocation = touch.location(in: self)
       sceneTouched(touchLocation: touchLocation)
     }
    
    
    //this is ovverride update function
    
  override func update(_ currentTime: TimeInterval) {
  
    
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
 labelNode.text = "Lives: \(lives)"
 labelNode.text = "Coins: \(coin)"
    if(coinsCollected >= 2)
       {
           spawnExit()
       }
    if lives <= 0 && !gameOver {
      gameOver = true
      print("You lose!")
        print("Your Final Score is " + String(finalScore))
        
        
//if the user loses the game he will se the you Lose screen
        
        
        let gameOver = GameOverScene(size: size, won: false)
     
        gameOver.scaleMode = scaleMode
        
        let reveal = SKTransition.flipHorizontal(withDuration: 0.5)

        view?.presentScene(gameOver, transition: reveal)

    } else if finalScore>=3 {
        print("You win!")
        print("Your Final Score is " + String(finalScore))
        
        
   //if the user wons the game he will se the you win screen
        
        
        let gameOver = GameOverScene(size: size, won: true)
           gameOver.scaleMode = scaleMode
          
           let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
           // 3
           view?.presentScene(gameOver, transition: reveal)
    }
    }

    // this fucntion checks the collision of the spikes from the panda
    
    func collideSpike()
      {
          var spikes:[SKSpriteNode] = []
          enumerateChildNodes(withName: "spike")
          {
              node, _ in
              let spike = node as! SKSpriteNode
              if spike.frame.insetBy(dx: 30, dy: 30).intersects(self.panda1.frame.insetBy(dx: 20, dy: 20))
              {
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
          { node ,_ in
                       
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
    
    // this function is to move the panda
  
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
       let amountToMove = CGPoint(x: velocity.x * CGFloat(dt),
                                  y: velocity.y * CGFloat(dt))
       print("Amount to move: \(amountToMove)")
       sprite.position += amountToMove
        
     }
    
    // this function helps in creating the rectangle so that panda should not go out of screen.
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
