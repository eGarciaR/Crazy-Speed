import SpriteKit

class BoostersNode: SKNode {
    
    var boostersNode : SKSpriteNode!
    
    override init() {
        super.init()
        
        boostersNode = SKSpriteNode(imageNamed: "layer")
        boostersNode.size = CGSizeMake(viewSize.width, viewSize.height/4)
        boostersNode.zPosition = 7
        addChild(boostersNode)
        
        let title = SKLabelNode(fontNamed: "Arial")
        title.text = "PAUSE"
        title.fontSize = CGFloat(viewSize.width / 10.5)
        title.position = CGPointMake(0, boostersNode.size.height*0.2)
        title.zPosition = 7
        boostersNode.addChild(title)
        
        /*let btnShield = SKSpriteNode(imageNamed: "shield")
        btnShield.name = "shield"
        btnShield.position = CGPointMake(boostersNode.size.width/3, -(boostersNode.size.height*0.2))
        btnShield.setScale(0.75)
        btnShield.zPosition = 7
        boostersNode.addChild(btnShield)*/
        
        let btnResume = SKSpriteNode(imageNamed: "play")
        btnResume.name = "resume"
        btnResume.position = CGPointMake(0, -(boostersNode.size.height*0.2))
        btnResume.setScale(0.75)
        btnResume.zPosition = 7
        boostersNode.addChild(btnResume)
        
        let btnSettings = SKSpriteNode(imageNamed: "settings")
        btnSettings.name = "settings"
        btnSettings.position = CGPointMake((-boostersNode.size.width/3), -(boostersNode.size.height*0.2))
        btnSettings.setScale(0.75)
        btnSettings.zPosition = 7
        boostersNode.addChild(btnSettings)
        
        let btnReturnMenu = SKSpriteNode(imageNamed: "quit")
        btnReturnMenu.name = "quit"
        btnReturnMenu.position = CGPointMake(boostersNode.size.width/3, -(boostersNode.size.height*0.2))
        btnReturnMenu.setScale(0.75)
        btnReturnMenu.zPosition = 7
        boostersNode.addChild(btnReturnMenu)
        
        /*let btnShots = SKSpriteNode(imageNamed: "shots")
        btnShots.name = "shots"
        btnShots.position = CGPointMake((-boostersNode.size.width/3), -(boostersNode.size.height*0.2))
        btnShots.setScale(0.75)
        btnShots.zPosition = 7
        boostersNode.addChild(btnShots)*/
        
        hidden = true
    }
    
    func show() {
        hidden = false
        boostersNode.position = CGPointMake(viewSize.width/2, viewSize.height/2)
        //let action = SKAction.moveToY(viewSize.height/2, duration: 5.0)
        //boostersNode.runAction(action)
    }
    
    func hide() {
        hidden = true
    }
    
    
    func hide(completion: () -> ()){
        let action = SKAction.moveToY(viewSize.height, duration: 0.4)
        let run = SKAction.runBlock({
            self.hidden = true
        })
        let sequence = SKAction.sequence([action, run])
        boostersNode.runAction(sequence, completion:  completion)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}