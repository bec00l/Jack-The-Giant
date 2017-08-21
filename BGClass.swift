//
//  BGClass.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/21/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import SpriteKit

class BGClass : SKSpriteNode {
    func moveBG(camera : SKCameraNode){
        if self.position.y - self.size.height - 10 > camera.position.y {
            self.position.y -=  self.size.height * 3
        }
    }
}
