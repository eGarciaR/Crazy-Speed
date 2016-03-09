//
//  purchasesNode.swift
//  Crazy Speed
//
//  Created by Eric Garcia Ribera on 09/03/16.
//  Copyright © 2016 EGR. All rights reserved.
//

import SpriteKit

class StoreNode: SKNode {
    
    var storeNode : SKSpriteNode!
    
    override init() {
        super.init()
        
        storeNode = SKSpriteNode(imageNamed: "layer")
        storeNode.size = CGSizeMake(viewSize.width, viewSize.height/2)
        storeNode.zPosition = 7
        addChild(storeNode)
        
        let title = SKLabelNode(fontNamed: "Arial")
        title.text = "STORE"
        title.fontSize = CGFloat(viewSize.width / 10.5)
        title.position = CGPointMake(0, storeNode.size.height*0.35)
        title.zPosition = 7
        storeNode.addChild(title)
        
        let btnReturnMenu = SKSpriteNode(imageNamed: "quit")
        btnReturnMenu.name = "quit"
        btnReturnMenu.position = CGPointMake(0, -(storeNode.size.height*0.4))
        btnReturnMenu.setScale(0.75)
        btnReturnMenu.zPosition = 7
        storeNode.addChild(btnReturnMenu)
        
        hidden = true
    }
    
    func show() {
        hidden = false
        storeNode.position = CGPointMake(viewSize.width/2, viewSize.height)
        let action = SKAction.moveToY(viewSize.height/2, duration: 0.5)
        storeNode.runAction(action)
    }
    
    func hide() {
        hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
