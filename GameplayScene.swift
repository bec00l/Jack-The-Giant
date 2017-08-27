//
//  GameplayScene.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/21/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import SpriteKit

class GameplayScene : SKScene, SKPhysicsContactDelegate {
    var cloudsController = CloudController()
    var player : Player?
    var mainCamera : SKCameraNode?
    var canMove : Bool = false
    var moveLeft = false
    var center : CGFloat?
    var distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(-160)
    let maxX = CGFloat(160)
    let playerMinX = CGFloat(-214.0)
    let playerMaxX = CGFloat(214.0)
    var bg1 : BGClass?
    var bg2 : BGClass?
    var bg3 : BGClass?
    
    private var accerleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    
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
        player?.setScore()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Life" {
            self.run(SKAction.playSoundFileNamed("Life Sound.wav", waitForCompletion: false))
            secondBody.node?.removeFromParent()
            GamePlayController.instance.incrementLife()
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            self.run(SKAction.playSoundFileNamed("Coin Sound.wav", waitForCompletion: false))
            secondBody.node?.removeFromParent()
            GamePlayController.instance.incrementCoin()
        } else if firstBody.node?.name == "Player" && secondBody.node?.name == "Dark Cloud" {
            self.scene?.isPaused = true
            GamePlayController.instance.lifeScore -= 1
            
            if GamePlayController.instance.lifeScore >= 0 {
                GamePlayController.instance.lifeText?.text = "x\(GamePlayController.instance.lifeScore)"
            } else {
                //show end score panel
            }
            
            firstBody.node?.removeFromParent()
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
            
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            
            if nodes(at: location)[0].name != "Pause" && nodes(at: location)[0].name != "Quit"
                && nodes(at: location)[0].name != "Resume"
            {
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
                loadMainMenu()
            }
            
            canMove = true
        }
    }
    
    func loadMainMenu () {
        let scene = MainMenuScene(fileNamed: "MainMenu")
        // Set the scale mode to scale to fit the window
        scene?.scaleMode = .aspectFill
        
        // Present the scene
        self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
    }
    
    func initializeVariables()  {
        physicsWorld.contactDelegate = self
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        player = self.childNode(withName: "Player") as! Player!
        player?.initializePlayerAndAnimations()
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode
        getBackgrounds()
        getLabels()
        GamePlayController.instance.initializeVariables()
        cloudsController.arrangeCloudsInScene(scence: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, player: player!, initialClouds: true)
        
        
        cameraDistanceForCreatingNewClouds = (mainCamera?.position.y)! - 400
        setCameraSpeed()
    }
    
    func getLabels() {
        GamePlayController.instance.coinText = self.mainCamera!.childNode(withName: "CoinText") as!SKLabelNode!
        GamePlayController.instance.scoreText = self.mainCamera!.childNode(withName: "ScoreText") as!SKLabelNode!
        GamePlayController.instance.lifeText = self.mainCamera!.childNode(withName: "LifeText") as!SKLabelNode!
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
        cameraSpeed += accerleration
        if cameraSpeed > maxSpeed {
            cameraSpeed = maxSpeed
        }
        self.mainCamera?.position.y -= cameraSpeed
    }
    
    func managePlayer(){
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
        
        if (player?.position.y)! - (player?.size.height)! * 3.7  > (mainCamera?.position.y)! {
            self.scene?.isPaused = true
            GamePlayController.instance.lifeScore -= 1
            
            if GamePlayController.instance.lifeScore >= 0 {
                GamePlayController.instance.lifeText?.text = "x\(GamePlayController.instance.lifeScore)"
            } else {
                //show end score panel
                createEndScorePanel()
            }
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        }
        
        if (player?.position.y)! + (player?.size.height)! * 3.7  < (mainCamera?.position.y)! {
            self.scene?.isPaused = true
            GamePlayController.instance.lifeScore -= 1
            
            if GamePlayController.instance.lifeScore >= 0 {
                GamePlayController.instance.lifeText?.text = "x\(GamePlayController.instance.lifeScore)"
            } else {
                //show end score panel
                createEndScorePanel()
            }
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
        }
        
        if (player?.position.x)! > playerMaxX {
            player?.position.x = playerMaxX
        }
        
        if (player?.position.x)! < playerMinX {
            player?.position.x = playerMinX
        }
        
        
    }
    
    func createNewClouds () {
        if cameraDistanceForCreatingNewClouds > (mainCamera?.position.y)! {
            cameraDistanceForCreatingNewClouds = (mainCamera?.position.y)! - 400
            
            cloudsController.arrangeCloudsInScene(scence: self.scene!, distanceBetweenClouds: distanceBetweenClouds, center: center!, minX: minX, maxX: maxX, player: player!, initialClouds: false)
        }
        
        checkForChildrenOutOfScreen()
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
    
    func createEndScorePanel() {
        let endScorePanel = SKSpriteNode(imageNamed: "Show Score")
        let scoreLabel = SKLabelNode(fontNamed: "Blow")
        let coinLabel = SKLabelNode(fontNamed: "Blow")
        
        endScorePanel.anchorPoint = CGPoint(x : 0.5, y : 0.5)
        endScorePanel.xScale = 1.5
        endScorePanel.yScale = 1.5
        endScorePanel.zPosition = 4
        endScorePanel.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.size.height)! / 2)
        
        scoreLabel.fontSize = 50
        coinLabel.fontSize = 50
        
        scoreLabel.zPosition = 7
        coinLabel.zPosition = 7
        
        scoreLabel.text = "\(GamePlayController.instance.score)"
        coinLabel.text = "\(GamePlayController.instance.coinScore)"
        
        
        scoreLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y + 10)
        
        coinLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y - 105)
        
        endScorePanel.addChild(scoreLabel)
        endScorePanel.addChild(coinLabel)
        mainCamera?.addChild(endScorePanel)
        
    }
    
    func checkForChildrenOutOfScreen () {
        for child in children {
            if child.position.y > (mainCamera?.position.y)!  + (self.scene?.size.height)! {
                let childName = child.name?.components(separatedBy: " ")
                if !(childName?.contains("BG"))! {
                    child.removeFromParent()
                }
                
            }
        }
    }
    
    private func setCameraSpeed() {
        if GameManager.instance.getEasyDifficulty() {
            accerleration = 0.001
            cameraSpeed = 1.5
            maxSpeed = 4
        }
        else if GameManager.instance.getMediumDifficulty(){
            accerleration = 0.002
            cameraSpeed = 2.0
            maxSpeed = 6
        }
        else if GameManager.instance.getHardDifficulty() {
            accerleration = 0.003
            cameraSpeed = 2.5
            maxSpeed = 8
        }
    }
    
    func playerDied () {
        if GamePlayController.instance.lifeScore >= 0 {
            GameManager.instance.gameRestartedPlayerDied = true
            
            let scene = GameplayScene(fileNamed: "GameplayScene")
            // Set the scale mode to scale to fit the window
            scene?.scaleMode = .aspectFill
            
            // Present the scene
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
        } else {
            if GameManager.instance.getEasyDifficulty() {
                let highScore = GameManager.instance.getEasyDifficultyScore()
                let coinScore = GameManager.instance.getEasyDifficultyCoinScore()
                
                if highScore < GamePlayController.instance.score {
                    GameManager.instance.setEasyDifficultyScore(easyDifficultyScore: GamePlayController.instance.score)
                }
                
                if coinScore < GamePlayController.instance.coinScore {
                    GameManager.instance.setEasyDifficultyCoinScore(easyDifficultyCoinScore: GamePlayController.instance.coinScore)
                }
            }
            else if GameManager.instance.getMediumDifficulty() {
                let highScore = GameManager.instance.getMediumDifficultyScore()
                let coinScore = GameManager.instance.getMediumDifficultyCoinScore()
                
                if highScore < GamePlayController.instance.score {
                    GameManager.instance.setMediumDifficultyScore(mediumDifficultyScore: GamePlayController.instance.score)
                }
                
                if coinScore < GamePlayController.instance.coinScore {
                    GameManager.instance.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: GamePlayController.instance.coinScore)
                }
            }
            else if GameManager.instance.getHardDifficulty() {
                let highScore = GameManager.instance.getHardDifficultyScore()
                let coinScore = GameManager.instance.getHardDifficultyCoinScore()
                
                if highScore < GamePlayController.instance.score {
                    GameManager.instance.setHardDifficultyScore(hardDifficultyScore: GamePlayController.instance.score)
                }
                
                if coinScore < GamePlayController.instance.coinScore {
                    GameManager.instance.setHardDifficultyCoinScore(hardDifficultyCoinScore: GamePlayController.instance.coinScore)
                }
            }
            
            GameManager.instance.saveData()
            loadMainMenu()
        }
    }
}
