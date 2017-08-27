//
//  HighScoreScene.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/22/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import SpriteKit

class HighScoreScene: SKScene {
    private var backButton : SKSpriteNode?
    private var scoreLabel : SKLabelNode?
    private var coinLabel : SKLabelNode?
    
    override func didMove(to view: SKView) {
        getReference()
        setScore()
    }
    
    private func getReference() {
        scoreLabel = self.childNode(withName: "Score Label") as? SKLabelNode
        coinLabel = self.childNode(withName: "Coin Label") as? SKLabelNode
        backButton = self.childNode(withName: "BackButton") as? SKSpriteNode
        
    }
    
    private func setScore() {
        if GameManager.instance.getEasyDifficulty() {
            scoreLabel?.text = "\(GameManager.instance.getEasyDifficultyScore())"
            coinLabel?.text = "\(GameManager.instance.getEasyDifficultyCoinScore())"
        }
        else if GameManager.instance.getMediumDifficulty(){
            scoreLabel?.text = "\(GameManager.instance.getMediumDifficultyScore())"
            coinLabel?.text = "\(GameManager.instance.getMediumDifficultyCoinScore())"
        }
        else if GameManager.instance.getHardDifficulty() {
            scoreLabel?.text = "\(GameManager.instance.getHardDifficultyScore())"
            coinLabel?.text = "\(GameManager.instance.getHardDifficultyCoinScore())"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNodes = nodes(at: location)
            
            if touchNodes[0].name == backButton?.name {
                let scene = MainMenuScene(fileNamed: "MainMenu")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // Present the scene
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
        }
    }

}
