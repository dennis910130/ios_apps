//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Si Chen on 7/28/15.
//  Copyright (c) 2015 Si Chen. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    var background = SKSpriteNode()
    let birdGroup:UInt32 = 1
    let objectGroup:UInt32 = 2
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let birdTexture = SKTexture(imageNamed: "img/flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "img/flappy2.png")
        
        let animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        
        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBirdFlap)
        let bgtexture = SKTexture(imageNamed: "img/bg.png")
        let movebg = SKAction.moveByX(-bgtexture.size().width, y: 0, duration: 9)
        let replacebg = SKAction.moveByX(bgtexture.size().width, y: 0, duration: 0)
        let moveForever = SKAction.repeatActionForever(SKAction.sequence([movebg, replacebg]))
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        bird.physicsBody?.dynamic = true
        bird.physicsBody?.allowsRotation = false
        bird.physicsBody?.categoryBitMask = birdGroup
        for var i = 0; i < 3; ++i {
            background = SKSpriteNode(texture: bgtexture)
            background.position = CGPoint(x: bgtexture.size().width / 2 + bgtexture.size().width * CGFloat(i), y: CGRectGetMidY(self.frame))
            background.size.height = self.frame.size.height
            background.runAction(moveForever)
            self.addChild(background)
        }
        
        
        self.addChild(bird)
        bird.zPosition = 100
        var ground = SKNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        ground.physicsBody?.dynamic = false
        self.addChild(ground)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("makePipes"), userInfo: nil, repeats: true)
        
        
        
    }
    
    func makePipes() {
        let pipeTexture = SKTexture(imageNamed: "img/pipe1.png")
        let pipeTexture2 = SKTexture(imageNamed: "img/pipe2.png")
        var pipe1 = SKSpriteNode(texture: pipeTexture)
        var pipe2 = SKSpriteNode(texture: pipeTexture2)
        pipe1.physicsBody?.categoryBitMask = objectGroup
        pipe2.physicsBody?.categoryBitMask = objectGroup
        let gap = bird.size.height * 3
        var len1:CGFloat = CGFloat(arc4random() % (UInt32(self.frame.height / 2))) + self.frame.height / 4
        var len2:CGFloat = self.frame.height - len1 - gap
        
        pipe1.size.width = bird.size.width
        pipe2.size.width = bird.size.width
        
        let pipeMovement = SKAction.moveByX(-self.frame.width * 2, y: 0, duration: NSTimeInterval(self.frame.width / 100))
        let removePipe = SKAction.removeFromParent()
        let total = SKAction.sequence([pipeMovement, removePipe])
        pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe2.size)
        pipe1.physicsBody?.dynamic = false
        pipe2.physicsBody?.dynamic = false
        pipe1.runAction(total)
        pipe2.runAction(total)
        
        pipe1.position = CGPointMake(CGRectGetMidX(self.frame) + self.frame.width, self.frame.height + pipe1.size.height / 2 - len1)
        pipe2.position = CGPointMake(CGRectGetMidX(self.frame) + self.frame.width, len2 - pipe2.size.height / 2)
        self.addChild(pipe1)
        self.addChild(pipe2)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        bird.physicsBody?.velocity = CGVectorMake(0, 0)
        bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
