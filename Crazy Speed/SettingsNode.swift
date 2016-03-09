//
//  SettingsNode.swift
//  Crazy Speed
//
//  Created by Eric Garcia Ribera on 08/03/16.
//  Copyright © 2016 EGR. All rights reserved.
//

import SpriteKit

class SettingsNode: SKNode {
    
    var settingsNode : SKSpriteNode!
    var btnMute : SKSpriteNode!
    var btnNoMute : SKSpriteNode!
    
    override init() {
        super.init()
        
        settingsNode = SKSpriteNode(imageNamed: "layer")
        settingsNode.size = CGSizeMake(viewSize.width*0.8, viewSize.height*0.75)
        settingsNode.zPosition = 7
        addChild(settingsNode)
        
        let title = SKLabelNode(fontNamed: "Arial")
        title.text = "SETTINGS"
        title.fontSize = CGFloat(viewSize.width / 10.5)
        title.position = CGPointMake(0, settingsNode.size.height*0.3)
        title.zPosition = 7
        settingsNode.addChild(title)
        
        /*let btnResume = SKSpriteNode(imageNamed: "play")
        btnResume.name = "resume"
        btnResume.position = CGPointMake(0, -(settingsNode.size.height*0.4))
        btnResume.setScale(0.75)
        btnResume.zPosition = 7
        settingsNode.addChild(btnResume)*/
        
        let btnReturnMenu = SKSpriteNode(imageNamed: "quit")
        btnReturnMenu.name = "quit"
        btnReturnMenu.position = CGPointMake(0, -(settingsNode.size.height*0.4))
        btnReturnMenu.setScale(0.75)
        btnReturnMenu.zPosition = 7
        settingsNode.addChild(btnReturnMenu)
        
        btnMute = SKSpriteNode(imageNamed: "mute")
        btnMute.name = "mute"
        btnMute.position = CGPointMake(0, 0)
        btnMute.setScale(1.5)
        btnMute.zPosition = 7
        btnMute.hidden = true
        settingsNode.addChild(btnMute)
        
        btnNoMute = SKSpriteNode(imageNamed: "noMute")
        btnNoMute.name = "noMute"
        btnNoMute.position = CGPointMake(0, 0)
        btnNoMute.setScale(1.5)
        btnNoMute.zPosition = 7
        btnNoMute.hidden = false
        settingsNode.addChild(btnNoMute)
        
        hidden = true
    }
    
    func show() {
        hidden = false
        settingsNode.position = CGPointMake(viewSize.width/2, viewSize.height)
        let action = SKAction.moveToY(viewSize.height/2, duration: 0.6)
        settingsNode.runAction(action)
    }
    
    func hide() {
        hidden = true
    }
    
    func mute() {
        btnNoMute.hidden = true
        btnMute.hidden = false
    }
    
    func noMute() {
        btnMute.hidden = true
        btnNoMute.hidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
