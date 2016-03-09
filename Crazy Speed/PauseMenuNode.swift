import SpriteKit

class PauseMenuNode: SKNode {
    
    var pauseNode : SKSpriteNode!
    
    override init() {
        super.init()
        
        pauseNode = SKSpriteNode(imageNamed: "layer")
        pauseNode.size = CGSizeMake(viewSize.width, viewSize.height/4)
        pauseNode.zPosition = 7
        addChild(pauseNode)
        
        let title = SKLabelNode(fontNamed: "Arial")
        title.text = "PAUSE"
        title.fontSize = CGFloat(viewSize.width / 10.5)
        title.position = CGPointMake(0, pauseNode.size.height*0.2)
        title.zPosition = 7
        pauseNode.addChild(title)
        
        /*let btnShield = SKSpriteNode(imageNamed: "shield")
        btnShield.name = "shield"
        btnShield.position = CGPointMake(pauseNode.size.width/3, -(pauseNode.size.height*0.2))
        btnShield.setScale(0.75)
        btnShield.zPosition = 7
        pauseNode.addChild(btnShield)*/
        
        let btnResume = SKSpriteNode(imageNamed: "play")
        btnResume.name = "resume"
        btnResume.position = CGPointMake(0, -(pauseNode.size.height*0.2))
        btnResume.setScale(0.75)
        btnResume.zPosition = 7
        pauseNode.addChild(btnResume)
        
        /*let btnSettings = SKSpriteNode(imageNamed: "settings")
        btnSettings.name = "settings"
        btnSettings.position = CGPointMake((-pauseNode.size.width/3), -(pauseNode.size.height*0.2))
        btnSettings.setScale(0.75)
        btnSettings.zPosition = 7
        pauseNode.addChild(btnSettings)*/
        
        let btnReturnMenu = SKSpriteNode(imageNamed: "quit")
        btnReturnMenu.name = "quit"
        btnReturnMenu.position = CGPointMake(pauseNode.size.width/3, -(pauseNode.size.height*0.2))
        btnReturnMenu.setScale(0.75)
        btnReturnMenu.zPosition = 7
        pauseNode.addChild(btnReturnMenu)
        
        /*let btnShots = SKSpriteNode(imageNamed: "shots")
        btnShots.name = "shots"
        btnShots.position = CGPointMake((-pauseNode.size.width/3), -(pauseNode.size.height*0.2))
        btnShots.setScale(0.75)
        btnShots.zPosition = 7
        pauseNode.addChild(btnShots)*/
        
        hidden = true
    }
    
    func show() {
        hidden = false
        pauseNode.position = CGPointMake(viewSize.width/2, viewSize.height/2)
        //let action = SKAction.moveToY(viewSize.height/2, duration: 5.0)
        //pauseNode.runAction(action)
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
        pauseNode.runAction(sequence, completion:  completion)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}