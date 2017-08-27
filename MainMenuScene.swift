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
    override func didMove(to view: SKView) {
        GameManager.instance.initializeGameData()
        highScoreButton = self.childNode(withName: "HighScore") as? SKSpriteNode
        startGameButton = self.childNode(withName: "StartGame") as? SKSpriteNode
        optionsButton = self.childNode(withName: "Options") as? SKSpriteNode
        quitButton = self.childNode(withName: "Quit") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchNodes = nodes(at: location)
            
            if touchNodes[0].name == highScoreButton?.name {
                let scene = HighScoreScene(fileNamed: "HighScoreScene")
                    // Set the scale mode to scale to fit the window
                    scene?.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
            if touchNodes[0].name == quitButton?.name {
                print("The quit button is pressed")
            }
            if touchNodes[0].name == optionsButton?.name {
                let scene = OptionsScene(fileNamed: "OptionsScene")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // Present the scene
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
            if touchNodes[0].name == startGameButton?.name {
                let scene = GameplayScene(fileNamed: "GameplayScene")
                // Set the scale mode to scale to fit the window
                scene?.scaleMode = .aspectFill
                
                // Present the scene
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
            }
        }
    }
}
