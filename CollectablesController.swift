//
//  CollectablesController.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/24/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import SpriteKit

class CollectablesController {
    
    func getCollectables() -> SKSpriteNode {
        var collectable = SKSpriteNode()
        if(Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 7)) >= 4) {
            if(GamePlayController.instance.lifeScore < 2) {
                collectable = SKSpriteNode(imageNamed: "Life")
                collectable.name = "Life"
                collectable.physicsBody = SKPhysicsBody(rectangleOf: collectable.size)
            }
            else {
                collectable.name = "Empty"
            }
        }
        else{
            collectable = SKSpriteNode(imageNamed: "Coin")
            collectable.name = "Coin"
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2)
        }
        
        collectable.physicsBody?.affectedByGravity = false
        collectable.physicsBody?.categoryBitMask = ColliderType.DarkCloudAndCollectibles
        collectable.physicsBody?.collisionBitMask = ColliderType.Player
        collectable.zPosition = 2
        return collectable
        
    }
    
    func randomBetweenNumbers (firstNumber : CGFloat, secondNumber : CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber) + min(firstNumber, secondNumber)
    }
}
