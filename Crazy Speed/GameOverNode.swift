import SpriteKit

class GameOverNode : SKNode {
    
    var gameOverNode : SKSpriteNode!
    
    override init() {
        super.init()
        
        gameOverNode = SKSpriteNode(imageNamed: "layer")
        gameOverNode.size = CGSizeMake(viewSize.width, viewSize.height/4)
        gameOverNode.zPosition = 7
        addChild(gameOverNode)
        
        let title = SKLabelNode(fontNamed: "Arial")
        title.text = "GAME OVER"
        title.fontSize = CGFloat(viewSize.width / 12.5)
        title.position = CGPointMake(0, gameOverNode.size.height*0.2)
        title.zPosition = 7
        gameOverNode.addChild(title)
        
        let btnLoad = SKSpriteNode(imageNamed: "load")
        btnLoad.name = "load"
        btnLoad.position = CGPointMake(0, -(gameOverNode.size.height*0.2))
        btnLoad.setScale(0.75)
        btnLoad.zPosition = 7
        gameOverNode.addChild(btnLoad)
        
        hidden = true
    }
    
    func show() {
        hidden = false
        gameOverNode.position = CGPointMake(viewSize.width/2, viewSize.height)
        let action = SKAction.moveToY(viewSize.height/2, duration: 0.4)
        gameOverNode.runAction(action)
    }
    
    func hide(completion: () -> ()){
        let action = SKAction.moveToY(viewSize.height, duration: 0.4)
        let run = SKAction.runBlock({
            self.hidden = true
        })
        let sequence = SKAction.sequence([action, run])
        gameOverNode.runAction(sequence, completion: completion)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
