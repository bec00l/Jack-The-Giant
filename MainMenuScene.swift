//
//  MainMenuScene.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/22/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import SpriteKit

class MainMenuScene : SKScene {
    var highScoreButton : SKSpriteNode?
    var startGameButton : SKSpriteNode?
    var optionsButton : SKSpriteNode?
    var quitButton : SKSpriteNode?
    
    private var musicButton : SKSpriteNode?
    private let musicOn = SKTexture(imageNamed: "Music On Button")
    private let musicOff = SKTexture(imageNamed: "Music Off Button")
    override func didMove(to view: SKView) {
        GameManager.instance.initializeGameData()
        
        musicButton = self.childNode(withName: "Music") as? SKSpriteNode
        highScoreButton = self.childNode(withName: "HighScore") as? SKSpriteNode
        startGameButton = self.childNode(withName: "StartGame") as? SKSpriteNode
        optionsButton = self.childNode(withName: "Options") as? SKSpriteNode
        quitButton = self.childNode(withName: "Quit") as? SKSpriteNode
        setMusic()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNodes = nodes(at: location)
            
            if touchNodes[0].name == highScoreButton?.name {
                let scene = HighScoreScene(fileNamed: "HighScoreScene")
                    // Set the scale mode to scale to fit the window
                    scene?.scaleMode = .aspectFill
                    runClickSound()
                    // Present the scene
                    self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
            if touchNodes[0].name == quitButton?.name {
                runClickSound()
                
            }
            
            if touchNodes[0].name == musicButton?.name {
                handleMusicButton()
            }
            if touchNodes[0].name == optionsButton?.name {
                let scene = OptionsScene(fileNamed: "OptionsScene")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                runClickSound()
                // Present the scene
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
            if touchNodes[0].name == startGameButton?.name {
                GameManager.instance.gameStartedFromMainMenu = true;
                let scene = GameplayScene(fileNamed: "GameplayScene")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                runClickSound()
                // Present the scene
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
        }
    }
    
    func runClickSound()
    {
        self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false))
    }
    
    private func setMusic() {
        if GameManager.instance.getIsMusicOn() {
            if AudioManager.instance.isAudioPlayerInitialized() {
                AudioManager.instance.playBGMusic()
                musicButton?.texture = musicOff
            }
        }
    }
    
    private func handleMusicButton() {
        if GameManager.instance.getIsMusicOn() {
            AudioManager.instance.stopBGMusic()
            GameManager.instance.setIsMusicOn(isMusicOn: false)
            musicButton?.texture = musicOn
        } else {
            AudioManager.instance.playBGMusic()
            GameManager.instance.setIsMusicOn(isMusicOn: true)
            musicButton?.texture = musicOff
        }
        
        GameManager.instance.saveData()
    }
}
