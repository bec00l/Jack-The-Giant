//
//  GameplayScene.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/21/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import SpriteKit

class GameplayScene : SKScene {
    var player : Player?
    var mainCamera : SKCameraNode?
    var canMove : Bool = false
    var moveLeft = false
    var center : CGFloat?
    
    
    override func didMove(to view: SKView) {
        initializeVariables()
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
        moveCamera()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x > center! {
                moveLeft = false
                player?.animatePlayer(moveLeft: moveLeft)
            }
            else {
                moveLeft = true
                player?.animatePlayer(moveLeft: moveLeft)
            }
            
            canMove = true
        }
    }
    
    func initializeVariables()  {
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        player = self.childNode(withName: "Player") as! Player!
        player?.initializePlayerAndAnimations()
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode
        
        
        
    }
    
    func moveCamera(){
        self.mainCamera?.position.y -= 3
    }
    
    func managePlayer(){
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
}
