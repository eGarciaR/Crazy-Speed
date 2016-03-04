//
//  CountdownNode.swift
//  Crazy Speed
//
//  Created by Eric Garcia Ribera on 03/03/16.
//  Copyright © 2016 EGR. All rights reserved.
//

import SpriteKit

class CountdownNode: SKSpriteNode {
    
    init(image: Int, position: CGPoint) {
        let texture = SKTexture(imageNamed: "number" + String(image))
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.name = "countdownNode"
        self.position = position
        self.setScale(5)
        self.zPosition = 6
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}