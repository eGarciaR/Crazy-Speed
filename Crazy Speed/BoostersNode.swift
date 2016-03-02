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
        title.text = "BOOSTERS!!!"
        title.fontSize = CGFloat(viewSize.width / 10.5)
        title.position = CGPointMake(0, boostersNode.size.height*0.2)
        title.zPosition = 7
        boostersNode.addChild(title)
        
        let btnShield = SKSpriteNode(imageNamed: "shield")
        btnShield.name = "shield"
        btnShield.position = CGPointMake(boostersNode.size.width/3, -(boostersNode.size.height*0.2))
        btnShield.setScale(0.75)
        btnShield.zPosition = 7
        boostersNode.addChild(btnShield)
        
        let btnResume = SKSpriteNode(imageNamed: "play")
        btnResume.name = "resume"
        btnResume.position = CGPointMake(0, -(boostersNode.size.height*0.2))
        btnResume.setScale(0.75)
        btnResume.zPosition = 7
        boostersNode.addChild(btnResume)
        
        let btnShots = SKSpriteNode(imageNamed: "shots")
        btnShots.name = "shots"
        btnShots.position = CGPointMake((-boostersNode.size.width/3), -(boostersNode.size.height*0.2))
        btnShots.setScale(0.75)
        btnShots.zPosition = 7
        boostersNode.addChild(btnShots)
        
        hidden = true
    }
    
    func show() {
        hidden = false
        boostersNode.position = CGPointMake(viewSize.width/2, viewSize.height/2)
        //let action = SKAction.moveToY(viewSize.height/2, duration: 5.0)
        //boostersNode.runAction(action)
    }
    
    
    func hide(){
        hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}