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
        storeNode.size = CGSizeMake(viewSize.width, viewSize.height*0.6)
        storeNode.zPosition = 7
        addChild(storeNode)
        
        let title = SKLabelNode(fontNamed: "Arial")
        title.text = "STORE"
        title.fontSize = CGFloat(viewSize.width / 10.5)
        title.position = CGPointMake(0, storeNode.size.height*0.4)
        title.zPosition = 7
        storeNode.addChild(title)
        
        let btnReturnMenu = SKSpriteNode(imageNamed: "quit")
        btnReturnMenu.name = "quit"
        btnReturnMenu.position = CGPointMake(0, -(storeNode.size.height*0.42))
        btnReturnMenu.setScale(0.75)
        btnReturnMenu.zPosition = 7
        storeNode.addChild(btnReturnMenu)
        
        let buyLifes = SKLabelNode(fontNamed: "Arial")
        buyLifes.text = "Buy lifes:"
        buyLifes.fontSize = CGFloat(viewSize.width / 18.5)
        buyLifes.position = CGPointMake(-(storeNode.size.width*0.35), storeNode.size.height*0.25)
        buyLifes.zPosition = 7
        storeNode.addChild(buyLifes)
        
        let buyShield = SKLabelNode(fontNamed: "Arial")
        buyShield.text = "Buy shield:"
        buyShield.fontSize = CGFloat(viewSize.width / 18.5)
        buyShield.position = CGPointMake(-(storeNode.size.width*0.35), -(storeNode.size.height*0.00))
        buyShield.zPosition = 7
        storeNode.addChild(buyShield)
        
        let buyAmmo = SKLabelNode(fontNamed: "Arial")
        buyAmmo.text = "Buy ammo:"
        buyAmmo.fontSize = CGFloat(viewSize.width / 18.5)
        buyAmmo.position = CGPointMake(-(storeNode.size.width*0.35), -(storeNode.size.height*0.25))
        buyAmmo.zPosition = 7
        storeNode.addChild(buyAmmo)
        
        let btn5Lifes = SKSpriteNode(imageNamed: "heart5Lifes")
        btn5Lifes.name = "add5Lifes"
        btn5Lifes.position = CGPointMake(-(storeNode.size.width*0.10), storeNode.size.height*0.25)
        btn5Lifes.setScale(0.95)
        btn5Lifes.zPosition = 7
        storeNode.addChild(btn5Lifes)
        
        let btn10Lifes = SKSpriteNode(imageNamed: "heart10Lifes")
        btn10Lifes.name = "add10Lifes"
        btn10Lifes.position = CGPointMake(storeNode.size.width*0.10, storeNode.size.height*0.25)
        btn10Lifes.setScale(1.1)
        btn10Lifes.zPosition = 7
        storeNode.addChild(btn10Lifes)
        
        let btn20Lifes = SKSpriteNode(imageNamed: "heart20Lifes")
        btn20Lifes.name = "add20Lifes"
        btn20Lifes.position = CGPointMake(storeNode.size.width*0.33, storeNode.size.height*0.25)
        btn20Lifes.setScale(1.4)
        btn20Lifes.zPosition = 7
        storeNode.addChild(btn20Lifes)
        
        let btn5Shield = SKSpriteNode(imageNamed: "shield5")
        btn5Shield.name = "add5Shield"
        btn5Shield.position = CGPointMake(-(storeNode.size.width*0.10), storeNode.size.height*0.00)
        btn5Shield.setScale(0.95)
        btn5Shield.zPosition = 7
        storeNode.addChild(btn5Shield)
        
        let btn10Shield = SKSpriteNode(imageNamed: "shield10")
        btn10Shield.name = "add10Shield"
        btn10Shield.position = CGPointMake(storeNode.size.width*0.10, storeNode.size.height*0.00)
        btn10Shield.setScale(1.1)
        btn10Shield.zPosition = 7
        storeNode.addChild(btn10Shield)
        
        let btn20Shield = SKSpriteNode(imageNamed: "shield20")
        btn20Shield.name = "add20Shield"
        btn20Shield.position = CGPointMake(storeNode.size.width*0.33, storeNode.size.height*0.00)
        btn20Shield.setScale(1.4)
        btn20Shield.zPosition = 7
        storeNode.addChild(btn20Shield)
        
        let btn5Shots = SKSpriteNode(imageNamed: "shots5")
        btn5Shots.name = "add5Shots"
        btn5Shots.position = CGPointMake(-(storeNode.size.width*0.10), -(storeNode.size.height*0.25))
        btn5Shots.setScale(0.95)
        btn5Shots.zPosition = 7
        storeNode.addChild(btn5Shots)
        
        let btn10Shots = SKSpriteNode(imageNamed: "shots10")
        btn10Shots.name = "add10Shots"
        btn10Shots.position = CGPointMake(storeNode.size.width*0.10, -(storeNode.size.height*0.25))
        btn10Shots.setScale(1.1)
        btn10Shots.zPosition = 7
        storeNode.addChild(btn10Shots)
        
        let btn20Shots = SKSpriteNode(imageNamed: "shots20")
        btn20Shots.name = "add20Shots"
        btn20Shots.position = CGPointMake(storeNode.size.width*0.33, -(storeNode.size.height*0.25))
        btn20Shots.setScale(1.4)
        btn20Shots.zPosition = 7
        storeNode.addChild(btn20Shots)
        
        
        /*Labels Precios*/
        let label099 = SKLabelNode(fontNamed: "Arial")
        label099.text = "0,99€"
        label099.fontSize = CGFloat(viewSize.width / 18.5)
        label099.position = CGPointMake(-(storeNode.size.width*0.10), storeNode.size.height*0.33)
        label099.zPosition = 8
        storeNode.addChild(label099)
        
        let label150 = SKLabelNode(fontNamed: "Arial")
        label150.text = "1,50€"
        label150.fontSize = CGFloat(viewSize.width / 18.5)
        label150.position = CGPointMake(storeNode.size.width*0.10, storeNode.size.height*0.33)
        label150.zPosition = 7
        storeNode.addChild(label150)
        
        let label250 = SKLabelNode(fontNamed: "Arial")
        label250.text = "2,50€"
        label250.fontSize = CGFloat(viewSize.width / 18.5)
        label250.position = CGPointMake(storeNode.size.width*0.33, storeNode.size.height*0.33)
        label250.zPosition = 8
        storeNode.addChild(label250)
        
        let label099m = SKLabelNode(fontNamed: "Arial")
        label099m.text = "0,99€"
        label099m.fontSize = CGFloat(viewSize.width / 18.5)
        label099m.position = CGPointMake(-(storeNode.size.width*0.10), storeNode.size.height*0.08)
        label099m.zPosition = 8
        storeNode.addChild(label099m)
        
        let label150m = SKLabelNode(fontNamed: "Arial")
        label150m.text = "1,50€"
        label150m.fontSize = CGFloat(viewSize.width / 18.5)
        label150m.position = CGPointMake(storeNode.size.width*0.10, storeNode.size.height*0.08)
        label150m.zPosition = 8
        storeNode.addChild(label150m)
        
        let label250m = SKLabelNode(fontNamed: "Arial")
        label250m.text = "2,50€"
        label250m.fontSize = CGFloat(viewSize.width / 18.5)
        label250m.position = CGPointMake(storeNode.size.width*0.33, storeNode.size.height*0.08)
        label250m.zPosition = 8
        storeNode.addChild(label250m)
        
        let label099b = SKLabelNode(fontNamed: "Arial")
        label099b.text = "0,99€"
        label099b.fontSize = CGFloat(viewSize.width / 18.5)
        label099b.position = CGPointMake(-(storeNode.size.width*0.10), -(storeNode.size.height*0.17))
        label099b.zPosition = 8
        storeNode.addChild(label099b)
        
        let label150b = SKLabelNode(fontNamed: "Arial")
        label150b.text = "1,50€"
        label150b.fontSize = CGFloat(viewSize.width / 18.5)
        label150b.position = CGPointMake(storeNode.size.width*0.10, -(storeNode.size.height*0.17))
        label150b.zPosition = 8
        storeNode.addChild(label150b)
        
        let label250b = SKLabelNode(fontNamed: "Arial")
        label250b.text = "2,50€"
        label250b.fontSize = CGFloat(viewSize.width / 18.5)
        label250b.position = CGPointMake(storeNode.size.width*0.33, -(storeNode.size.height*0.17))
        label250b.zPosition = 8
        storeNode.addChild(label250b)
        
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
