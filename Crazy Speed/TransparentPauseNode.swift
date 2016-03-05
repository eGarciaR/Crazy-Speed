//
//  TransparentPauseNode.swift
//  Crazy Speed
//
//  Created by Eric Garcia Ribera on 04/03/16.
//  Copyright © 2016 EGR. All rights reserved.
//

import SpriteKit

class TransparentPauseNode: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "layer")
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(viewSize.width/6, viewSize.height/10))
        self.alpha = 0.01 // Es una manera de hacer transparente el nodo, si se usa 0.0 el nodo no es detectado cuando se toca
        
        self.name = "transparentPauseNode"
        self.position = position
        self.zPosition = 8
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}