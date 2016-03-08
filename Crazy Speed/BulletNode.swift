//
//  BulletNode.swift
//  Crazy Speed
//
//  Created by Eric Garcia Ribera on 02/03/16.
//  Copyright © 2016 EGR. All rights reserved.
//

import SpriteKit

class BulletNode: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "bullet")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.name = "bullet"
        self.position = position
        self.setScale(0.50)
        self.zPosition = 3
        
    }
    
    func loadPhysicsBody(){
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width, self.size.height))
        self.physicsBody?.velocity = CGVectorMake(0, 200)
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.friction = 0.0
        self.physicsBody?.mass = 0.0
        self.physicsBody?.categoryBitMask = kCCBulletCategory
        self.physicsBody?.contactTestBitMask = kCCOtherCarsCategory
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}