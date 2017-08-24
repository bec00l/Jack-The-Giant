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
    override func didMove(to view: SKView) {
        backButton = self.childNode(withName: "BackButton") as? SKSpriteNode
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
