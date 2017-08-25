//
//  GameManager.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/23/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import Foundation

class GameManager {
    static let instance = GameManager()
    private init() {}
    
    var gameStartedFromMainMenu = true
    var gameRestartedPlayerDied = false
}
