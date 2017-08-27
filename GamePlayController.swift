//
//  GamePlayController.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/23/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import Foundation
import SpriteKit

class GamePlayController {
    
    static let instance = GamePlayController()
    
    var scoreText : SKLabelNode?
    var lifeText : SKLabelNode?
    var coinText : SKLabelNode?
    
    var score : Int32 = 0
    var coinScore : Int32 = 0
    var lifeScore : Int32 = 0
    
    private init () {
        
    }
    
    func initializeVariables() {
        if GameManager.instance.gameStartedFromMainMenu {
            GameManager.instance.gameStartedFromMainMenu = false
            score = -1
            coinScore = 0
            lifeScore = 2
            
            scoreText?.text = "\(score)"
            coinText?.text = "x\(coinScore)"
            lifeText?.text = "x\(lifeScore)"
        }
        else if GameManager.instance.gameRestartedPlayerDied {
            GameManager.instance.gameRestartedPlayerDied = false;
            scoreText?.text = "\(score)"
            coinText?.text = "x\(coinScore)"
            lifeText?.text = "x\(lifeScore)"
        }
    }
    
    func incrementScore()  {
        score += 1
        scoreText?.text = "\(score)"
    }
    
    func incrementLife()  {
        lifeScore += lifeScore
        lifeText?.text = "x\(lifeScore)"
        score += 300
        scoreText?.text = "\(score)"
        
    }
    
    func incrementCoin()  {
        coinScore += 1
        coinText?.text = "x\(coinScore)"
        score += 200
        scoreText?.text = "\(score)"
    }
    
}

