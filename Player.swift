//
//  Player.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/21/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import SpriteKit

class Player  : SKSpriteNode {
    
    func movePlayer(moveLeft: Bool){
        if moveLeft {
            self.position.x = self.position.x - 7
        }
        else {
            self.position.x = self.position.x + 7
        }
    }
}


