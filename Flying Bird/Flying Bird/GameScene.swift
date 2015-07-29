//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Si Chen on 7/28/15.
//  Copyright (c) 2015 Si Chen. All rights reserved.
//

import SpriteKit
import CoreData

class GameScene: SKScene, SKPhysicsContactDelegate {
    var highestLabel = SKLabelNode()
    var latestLabel = SKLabelNode()
    var bird = SKSpriteNode()
    var background = SKSpriteNode()
    let birdGroup:UInt32 = 1
    let objectGroup:UInt32 = 2
    let gapGroup:UInt32 = 1 << 3
    let scoreLabel = SKLabelNode()
    var gameOver = true
    var timer = NSTimer()
    var movingObject = SKNode()
    var score = 0
    var highest = 0
    var latest = 0
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        /* Setup your scene here */
        
        let birdTexture = SKTexture(imageNamed: "img/flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "img/flappy2.png")
        self.physicsWorld.gravity = CGVectorMake(0, -10)
        let animation = SKAction.animateWithTextures([birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        self.addChild(scoreLabel)
        self.addChild(highestLabel)
        self.addChild(latestLabel)
        self.addChild(movingObject)
        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBirdFlap)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        bird.physicsBody?.dynamic = false
        bird.physicsBody?.allowsRotation = false
        bird.physicsBody?.categoryBitMask = birdGroup
        bird.physicsBody?.collisionBitMask = objectGroup
        bird.physicsBody?.contactTestBitMask = objectGroup
        
        
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("highest") {
            highest = value as! Int
        } else {
            highest = 0
        }
        if let value = NSUserDefaults.standardUserDefaults().objectForKey("latest") {
            latest = value as! Int
        } else {
            latest = 0
        }

        highestLabel.fontName = "Helvetica"

        highestLabel.position = CGPointMake(100, self.view!.frame.height - 20)
        highestLabel.fontSize = 20
        highestLabel.fontColor = UIColor.redColor()
        highestLabel.text = "Highest: \(highest)"
        highestLabel.zPosition = 1000
        highestLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        latestLabel.fontName = "Helvetica"
        latestLabel.position = CGPointMake(100, self.view!.frame.height - 40)
        latestLabel.fontSize = 20
        latestLabel.text = "Latest: \(latest)"
        latestLabel.zPosition = 1000
        latestLabel.fontColor = UIColor.redColor()
        latestLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        
        
        
        self.addChild(bird)
        bird.zPosition = 100
        var ground = SKNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = objectGroup
        self.addChild(ground)
        
        
        let bgtexture = SKTexture(imageNamed: "img/bg.png")
        let movebg = SKAction.moveByX(-bgtexture.size().width, y: 0, duration: 9)
        let replacebg = SKAction.moveByX(bgtexture.size().width, y: 0, duration: 0)
        let moveForever = SKAction.repeatActionForever(SKAction.sequence([movebg, replacebg]))
        for var i = 0; i < 3; ++i {
            background = SKSpriteNode(texture: bgtexture)
            background.position = CGPoint(x: bgtexture.size().width / 2 + bgtexture.size().width * CGFloat(i), y: CGRectGetMidY(self.frame))
            background.size.height = self.frame.size.height
            background.runAction(moveForever)
            movingObject.addChild(background)
        }
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 30
        scoreLabel.text = "Tab to start"
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 70)
        scoreLabel.zPosition = 100
    }
    
    func makeBackground() {
        score = 0
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 30
        scoreLabel.text = "0"
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 70)
        scoreLabel.zPosition = 100
        let bgtexture = SKTexture(imageNamed: "img/bg.png")
        let movebg = SKAction.moveByX(-bgtexture.size().width, y: 0, duration: 9)
        let replacebg = SKAction.moveByX(bgtexture.size().width, y: 0, duration: 0)
        let moveForever = SKAction.repeatActionForever(SKAction.sequence([movebg, replacebg]))
        for var i = 0; i < 3; ++i {
            background = SKSpriteNode(texture: bgtexture)
            background.position = CGPoint(x: bgtexture.size().width / 2 + bgtexture.size().width * CGFloat(i), y: CGRectGetMidY(self.frame))
            background.size.height = self.frame.size.height
            background.runAction(moveForever)
            movingObject.addChild(background)
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(2.5, target: self, selector: Selector("makePipes"), userInfo: nil, repeats: true)
    }
    
    func makePipes() {
        let pipeTexture = SKTexture(imageNamed: "img/pipe1.png")
        let pipeTexture2 = SKTexture(imageNamed: "img/pipe2.png")
        var pipe1 = SKSpriteNode(texture: pipeTexture)
        var pipe2 = SKSpriteNode(texture: pipeTexture2)
        
        let gap = bird.size.height * 2.5
        var len1:CGFloat = CGFloat(arc4random() % (UInt32(self.frame.height / 2))) + self.frame.height / 4
        var len2:CGFloat = self.frame.height - len1 - gap
        
        pipe1.size.width = bird.size.width
        pipe2.size.width = bird.size.width
        
        var gapObject = SKNode()
        
        
        let pipeMovement = SKAction.moveByX(-self.frame.width * 2, y: 0, duration: NSTimeInterval(self.frame.width / 100))
        let removePipe = SKAction.removeFromParent()
        let total = SKAction.sequence([pipeMovement, removePipe])
        pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe2.size)
        pipe1.physicsBody?.dynamic = false
        pipe2.physicsBody?.dynamic = false
        pipe1.physicsBody?.categoryBitMask = objectGroup
        pipe2.physicsBody?.categoryBitMask = objectGroup
        pipe1.runAction(total)
        pipe2.runAction(total)
        
        pipe1.position = CGPointMake(CGRectGetMidX(self.frame) + self.frame.width, self.frame.height + pipe1.size.height / 2 - len1)
        pipe2.position = CGPointMake(CGRectGetMidX(self.frame) + self.frame.width, len2 - pipe2.size.height / 2)
        gapObject.position = CGPointMake(pipe1.position.x, len2 + gap / 2)
        gapObject.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(pipe1.size.width - 2, gap))
        gapObject.physicsBody?.dynamic = false
        gapObject.physicsBody?.categoryBitMask = gapGroup
        gapObject.physicsBody?.collisionBitMask = gapGroup
        gapObject.physicsBody?.contactTestBitMask = birdGroup
        gapObject.runAction(total)
        movingObject.addChild(gapObject)
        movingObject.addChild(pipe1)
        movingObject.addChild(pipe2)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == gapGroup || contact.bodyB.categoryBitMask == gapGroup {
            score++
            scoreLabel.text = "\(score)"
            
        } else {
            latest = score
            if latest > highest {
                NSUserDefaults.standardUserDefaults().setObject(NSNumber(integerLiteral: latest), forKey: "highest")
                highest = latest
            }
            NSUserDefaults.standardUserDefaults().setObject(NSNumber(integerLiteral: latest), forKey: "latest")
            highestLabel.text = "Highest: \(highest)"
            latestLabel.text = "Latest: \(latest)"
            gameOver = true
            movingObject.speed = 0
            scoreLabel.fontSize = 20
            scoreLabel.text = "Game Over!\nTab to play again!"
            scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            timer.invalidate()
        }
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if gameOver == false {
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            bird.physicsBody?.applyImpulse(CGVectorMake(0, 50))
        } else {
            movingObject.removeAllChildren()
            makeBackground()
            bird.physicsBody?.dynamic = true
            bird.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            bird.physicsBody?.velocity = CGVectorMake(0, 0)
            gameOver = false
            movingObject.speed = 1
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
