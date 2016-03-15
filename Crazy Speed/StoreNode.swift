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
        
        let buyLifes = SKLabelNode(fontNamed: "Arial")
        buyLifes.text = "Buy lifes:"
        buyLifes.fontSize = CGFloat(viewSize.width / 18.5)
        buyLifes.position = CGPointMake(-(storeNode.size.width*0.35), storeNode.size.height*0.20)
        buyLifes.zPosition = 7
        storeNode.addChild(buyLifes)
        
        let btn5Lifes = SKSpriteNode(imageNamed: "heart5Lifes")
        btn5Lifes.name = "add5Lifes"
        btn5Lifes.position = CGPointMake(-(storeNode.size.width*0.10), storeNode.size.height*0.20)
        btn5Lifes.setScale(0.95)
        btn5Lifes.zPosition = 7
        storeNode.addChild(btn5Lifes)
        
        let btn10Lifes = SKSpriteNode(imageNamed: "heart10Lifes")
        btn10Lifes.name = "add10Lifes"
        btn10Lifes.position = CGPointMake(storeNode.size.width*0.10, storeNode.size.height*0.20)
        btn10Lifes.setScale(1.1)
        btn10Lifes.zPosition = 7
        storeNode.addChild(btn10Lifes)
        
        let btn20Lifes = SKSpriteNode(imageNamed: "heart20Lifes")
        btn20Lifes.name = "add20Lifes"
        btn20Lifes.position = CGPointMake(storeNode.size.width*0.33, storeNode.size.height*0.20)
        btn20Lifes.setScale(1.4)
        btn20Lifes.zPosition = 7
        storeNode.addChild(btn20Lifes)
        
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
