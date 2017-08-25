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
    
    var score : Int?
    var coinScore : Int?
    var lifeScore : Int?
    
    private init () {
        
    }
    
    func initializeVariables() {
        if GameManager.instance.gameStartedFromMainMenu {
            GameManager.instance.gameStartedFromMainMenu = false
            score = 0
            coinScore = 0
            lifeScore = 2
            
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coinScore!)"
            lifeText?.text = "x\(lifeScore!)"
        }
        else if GameManager.instance.gameRestartedPlayerDied {
            scoreText?.text = "\(score!)"
            coinText?.text = "x\(coinScore!)"
            lifeText?.text = "x\(lifeScore!)"
        }
    }
    
    func incrementScore()  {
        score! += 1
        scoreText?.text = "\(score ?? 0)"
    }
    
    func incrementLife()  {
        lifeScore! += 1
        lifeText?.text = "x\(lifeScore ?? 2)"
        score! += 300
        scoreText?.text = "\(score ?? 0)"
        
    }
    
    func incrementCoin()  {
        coinScore! += 1
        coinText?.text = "x\(coinScore ?? 0)"
        score! += 200
        scoreText?.text = "\(score ?? 0)"
    }
    
}

