//
//  SettingsNode.swift
//  Crazy Speed
//
//  Created by Eric Garcia Ribera on 12/08/16.
//  Copyright © 2016 EGR. All rights reserved.
//

import SpriteKit

class CarSelectionNode: SKNode {
    
    var carSelectionNode : SKSpriteNode!
    var formula1 : SKSpriteNode!
    var viper : SKSpriteNode!
    var camaro : SKSpriteNode!
    var audiR8 : SKSpriteNode!
    
    override init() {
        super.init()
        
        carSelectionNode = SKSpriteNode(imageNamed: "layer")
        carSelectionNode.size = CGSizeMake(viewSize.width, viewSize.height/2)
        carSelectionNode.zPosition = 8
        addChild(carSelectionNode)
        
        let title = SKLabelNode(fontNamed: "Arial")
        title.text = "SELECT A CAR"
        title.fontSize = CGFloat(viewSize.width / 10.5)
        title.position = CGPointMake(0, carSelectionNode.size.height*0.35)
        title.zPosition = 8
        carSelectionNode.addChild(title)
        
        let btnReturnMenu = SKSpriteNode(imageNamed: "quit")
        btnReturnMenu.name = "quit"
        btnReturnMenu.position = CGPointMake(0, -(carSelectionNode.size.height*0.4))
        btnReturnMenu.setScale(0.75)
        btnReturnMenu.zPosition = 8
        carSelectionNode.addChild(btnReturnMenu)
        
        formula1 = SKSpriteNode(imageNamed: "formula1")
        formula1.name = "formula1"
        formula1.position = CGPointMake(-150, 0)
        formula1.zPosition = 8
        carSelectionNode.addChild(formula1)
        
        viper = SKSpriteNode(imageNamed: "viper")
        viper.name = "viper"
        viper.position = CGPointMake(-50, 0)
        viper.zPosition = 8
        carSelectionNode.addChild(viper)
        
        camaro = SKSpriteNode(imageNamed: "car")
        camaro.name = "camaro"
        camaro.position = CGPointMake(50, 0)
        camaro.zPosition = 8
        carSelectionNode.addChild(camaro)
        
        audiR8 = SKSpriteNode(imageNamed: "audiR8")
        audiR8.name = "audiR8"
        audiR8.position = CGPointMake(150, 0)
        audiR8.zPosition = 8
        carSelectionNode.addChild(audiR8)
        
        hidden = true
    }
    
    func show() {
        hidden = false
        carSelectionNode.position = CGPointMake(viewSize.width/2, viewSize.height)
        let action = SKAction.moveToY(viewSize.height/2, duration: 0.5)
        carSelectionNode.runAction(action)
    }
    
    func hide() {
        hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}