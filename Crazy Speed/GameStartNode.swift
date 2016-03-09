import SpriteKit

class GameStartNode : SKNode {
    
    var startNode : SKSpriteNode!
    var timeNode : SKLabelNode!
    
    override init() {
        super.init()
        
        startNode = SKSpriteNode(imageNamed: "layer")
        startNode.position = CGPointMake(viewSize.width/2, viewSize.height/2)
        startNode.size = CGSizeMake(viewSize.width, viewSize.height/4)
        startNode.zPosition = 8
        addChild(startNode)

        let title = SKLabelNode(fontNamed: "Arial")
        title.text = "CRAZY SPEED"
        title.fontColor = SKColor.yellowColor()
        title.fontSize = CGFloat(viewSize.width / 12.5)
        title.position = CGPointMake(0, startNode.size.height*0.2)
        title.zPosition = 8
        startNode.addChild(title)
        
        let btnStart = SKSpriteNode(imageNamed: "play")
        btnStart.name = "play"
        btnStart.position = CGPointMake(startNode.size.width*(-0.3), -(startNode.size.height*0.1))
        btnStart.setScale(0.75)
        btnStart.zPosition = 8
        startNode.addChild(btnStart)
        
        let btnSettings = SKSpriteNode(imageNamed: "settings")
        btnSettings.name = "settings"
        btnSettings.position = CGPointMake(0, -(startNode.size.height*0.1))
        btnSettings.setScale(0.75)
        btnSettings.zPosition = 8
        startNode.addChild(btnSettings)
        
        let btnShop = SKSpriteNode(imageNamed: "shop")
        btnShop.name = "shop"
        btnShop.position = CGPointMake(startNode.size.width*0.3, -(startNode.size.height*0.1))
        btnShop.setScale(0.75)
        btnShop.zPosition = 8
        startNode.addChild(btnShop)
        
        timeNode = SKLabelNode(fontNamed: "Arial")
        timeNode.fontSize = CGFloat(viewSize.width / 18.75)
        timeNode.position = CGPointMake(-(startNode.size.width*0.1), -(startNode.size.height*0.4))
        timeNode.zPosition = 8
        timeNode.horizontalAlignmentMode = .Left
        startNode.addChild(timeNode)
    }
    
    func updateTime(time: CFTimeInterval){
        timeNode.text = Util.timeString(time)
    }
    
    func show() {
        alpha = 1.0
        hidden = false
        timeNode.hidden = lifes >= 5
        startNode.position = CGPointMake(viewSize.width/2, viewSize.height)
        let action = SKAction.moveToY(viewSize.height/2, duration: 0.5)
        startNode.runAction(action)
    }
    
    func hide(completion: () -> ()){
        let fade = SKAction.fadeOutWithDuration(1)
        let run = SKAction.runBlock({
            self.hidden = true
        })
        let sequence = SKAction.sequence([fade, run])
        runAction(sequence, completion: completion)
    }
    
    func hide() {
        hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
