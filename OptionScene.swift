//
//  OptionScene.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/22/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import SpriteKit

class OptionsScene: SKScene {
    var backButton : SKSpriteNode?
    
    private var easyButton : SKSpriteNode?
    private var mediumButton : SKSpriteNode?
    private var hardButton : SKSpriteNode?
    
    private var sign : SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        backButton = self.childNode(withName: "BackButton") as? SKSpriteNode
        intitializeVariables()
        setSign()
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
            
            if touchNodes[0].name == easyButton?.name {
                sign?.position.y = (easyButton?.position.y)!
                setDifficulty(difficulty: "easy")
            }
            
            if touchNodes[0].name == mediumButton?.name {
                sign?.position.y = (mediumButton?.position.y)!
                setDifficulty(difficulty: "medium")
            }
            
            if touchNodes[0].name == hardButton?.name {
                sign?.position.y = (hardButton?.position.y)!
                setDifficulty(difficulty: "hard")
            }
            
            sign?.zPosition = 4
        }
    }
    
    func intitializeVariables() {
        easyButton = self.childNode(withName: "Easy Button") as? SKSpriteNode
        mediumButton = self.childNode(withName: "Medium Button") as? SKSpriteNode
        hardButton = self.childNode(withName: "Hard Button") as? SKSpriteNode
        sign = self.childNode(withName: "Check Sign") as? SKSpriteNode
    }
    
    func setSign() {
        if GameManager.instance.getEasyDifficulty() {
            sign?.position.y = (easyButton?.position.y)!
        }
        else if GameManager.instance.getMediumDifficulty(){
            sign?.position.y = (mediumButton?.position.y)!
        }
        else if GameManager.instance.getHardDifficulty() {
            sign?.position.y = (hardButton?.position.y)!
        }
    }
    
    private func setDifficulty(difficulty : String){
        switch difficulty {
        case "easy":
            GameManager.instance.setEasyDifficulty(easyDifficulty: true)
            GameManager.instance.setMediumDifficulty(mediumDifficulty: false)
            GameManager.instance.setHardDifficulty(hardDifficulty: false)
            break
        case "medium":
            GameManager.instance.setEasyDifficulty(easyDifficulty: false)
            GameManager.instance.setMediumDifficulty(mediumDifficulty: true)
            GameManager.instance.setHardDifficulty(hardDifficulty: false)
            break
        case "hard":
            GameManager.instance.setEasyDifficulty(easyDifficulty: false)
            GameManager.instance.setMediumDifficulty(mediumDifficulty: false)
            GameManager.instance.setHardDifficulty(hardDifficulty: true)
            break
        default:
            break
        }
        
        GameManager.instance.saveData()
    }

}
