//
//  Player.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/21/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import SpriteKit

struct ColliderType {
    static let Player : UInt32 = 0
    static let Cloud : UInt32 = 1
    static let DarkCloudAndCollectibles : UInt32 = 2
}

class Player  : SKSpriteNode {
    private var textureAtlas = SKTextureAtlas()
    private var playerAnimation = [SKTexture]()
    private var animatePlayerAction = SKAction()
    private var lastY = CGFloat()
    let playerWidthOffset : CGFloat = 50
    let playerHeightOffset : CGFloat = 5
    
    func movePlayer(moveLeft: Bool){
        if moveLeft {
            self.position.x -= 7
        }
        else {
            self.position.x += 7
        }
    }
    
    func initializePlayerAndAnimations()  {
        textureAtlas = SKTextureAtlas(named: "Player.atlas")
        for i in 2...textureAtlas.textureNames.count {
            let name = "Player \(i)"
            playerAnimation.append(SKTexture(imageNamed: name))
        }
        animatePlayerAction = SKAction.animate(with: playerAnimation, timePerFrame: 0.08, resize: true, restore: false)
        
        //add physics
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width : self.size.width - playerWidthOffset, height : self.size.height - playerHeightOffset))
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.categoryBitMask = ColliderType.Player
        self.physicsBody?.collisionBitMask = ColliderType.Cloud
        self.physicsBody?.contactTestBitMask = ColliderType.DarkCloudAndCollectibles
        
        setLastYPosition()
    }
    
    func animatePlayer(moveLeft : Bool) {
        if moveLeft {
            self.xScale = -fabs(self.xScale)
        }
        else{
            self.xScale = fabs(self.xScale)
        }
        self.run(SKAction.repeatForever(animatePlayerAction), withKey: "Animate")
    }
    
    func stopPlayerAnimation(){
        self.removeAction(forKey: "Animate")
        self.texture = SKTexture(imageNamed: "Player 1")
        self.size = (self.texture?.size())!
    }
    
    func setScore() {
        if self.position.y < lastY {
            GamePlayController.instance.incrementScore()
            setLastYPosition()
        }
    }
    
    func setLastYPosition () {
        lastY = self.position.y
    }
}


