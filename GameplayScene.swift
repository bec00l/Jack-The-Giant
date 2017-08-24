//
//  GameplayScene.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/21/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import SpriteKit

class GameplayScene : SKScene {
    var cloudsController = CloudController()
    var player : Player?
    var mainCamera : SKCameraNode?
    var canMove : Bool = false
    var moveLeft = false
    var center : CGFloat?
    var distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(-160)
    let maxX = CGFloat(160)
    var bg1 : BGClass?
    var bg2 : BGClass?
    var bg3 : BGClass?
    
    private var cameraDistanceForCreatingNewClouds =  CGFloat()
    private var pausePanel : SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        initializeVariables()
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
        moveCamera()
        manageBackgrounds()
        createNewClouds()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if self.scene?.isPaused == false {
                if location.x > center! {
                    moveLeft = false
                    player?.animatePlayer(moveLeft: moveLeft)
                }
                else {
                    moveLeft = true
                    player?.animatePlayer(moveLeft: moveLeft)
                }
            }
            
            if nodes(at: location)[0].name == "Pause" {
                self.scene?.isPaused = true
                createPausePanel()
            }
            
            if nodes(at: location)[0].name == "Resume" {
                pausePanel?.removeFromParent()
                self.scene?.isPaused = false
            }
            
            if nodes(at: location)[0].name == "Quit" {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // Present the scene
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
            
            canMove = true
        }
    }
    
    func initializeVariables()  {
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        player = self.childNode(withName: "Player") as! Player!
        player?.initializePlayerAndAnimations()
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode
        getBackgrounds()
        cloudsController.arrangeCloudsInScene(scence: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: true)
        
        
        cameraDistanceForCreatingNewClouds = (mainCamera?.position.y)! - 400
    }
    
    func getBackgrounds() {
        bg1 = self.childNode(withName: "BG 1") as? BGClass!
        bg2 = self.childNode(withName: "BG 2") as? BGClass!
        bg3 = self.childNode(withName: "BG 3") as? BGClass!
    }
    
    func manageBackgrounds() {
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
    
    func moveCamera(){
        self.mainCamera?.position.y -= 3
    }
    
    func managePlayer(){
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
    }
    
    func createNewClouds () {
        if cameraDistanceForCreatingNewClouds > (mainCamera?.position.y)! {
            cameraDistanceForCreatingNewClouds = (mainCamera?.position.y)! - 400
            
            cloudsController.arrangeCloudsInScene(scence: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, initialClouds: false)
        }
    }
    
    func createPausePanel() {
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        let resumeButton = SKSpriteNode(imageNamed: "Resume Button")
        let quitButton = SKSpriteNode(imageNamed: "Quit Button 2")
        pausePanel?.anchorPoint = CGPoint(x : 0.5, y : 0.5)
        pausePanel?.xScale = 1.6
        pausePanel?.yScale = 1.6
        pausePanel?.zPosition = 4
        pausePanel?.position = CGPoint(x: (self.mainCamera?.frame.width)! / 2, y: (self.mainCamera?.frame.height)! / 2)
        
        resumeButton.name = "Resume"
        resumeButton.zPosition = 5
        resumeButton.anchorPoint = CGPoint(x : 0.5, y : 0.5)
        resumeButton.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! + 25)
        
        quitButton.name = "Quit"
        quitButton.zPosition = 5
        quitButton.anchorPoint = CGPoint(x : 0.5, y : 0.5)
        quitButton.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! - 45)
        
        pausePanel?.addChild(resumeButton)
        pausePanel?.addChild(quitButton)
        
        self.mainCamera?.addChild(pausePanel!)
    }
}
