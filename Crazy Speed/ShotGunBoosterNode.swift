//
//  ShotGunBoosterNode.swift
//  Crazy Speed
//
//  Created by Eric Garcia Ribera on 05/03/16.
//  Copyright © 2016 EGR. All rights reserved.
//

import SpriteKit

class ShotGunBoosterNode: SKSpriteNode {
    
    var quantity : SKLabelNode!
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "shots")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        self.name = "shots"
        self.position = position
        self.zPosition = 4
        if UIScreen.mainScreen().bounds.width <= 400 {self.setScale(0.60)}
        else if UIScreen.mainScreen().bounds.width > 400 && UIScreen.mainScreen().bounds.width < 500 {self.setScale(0.9)}
        else {self.setScale(1)}
        self.zRotation = CGFloat(180.1/M_PI)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}