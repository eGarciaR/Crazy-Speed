import SpriteKit

class HUDNode : SKNode {
    var top: SKSpriteNode!
    var bottom: SKSpriteNode!
    
    override init() {
        super.init()
        
        top = SKSpriteNode(imageNamed: "hud")
        top.anchorPoint = CGPointMake(0, 1)
        top.position = CGPointMake(0, viewSize.height)
        top.size = CGSizeMake(viewSize.width, top.size.height * 0.5)
        top.zPosition = 5
        addChild(top)
        
        bottom = SKSpriteNode(imageNamed: "hud")
        bottom.anchorPoint = CGPointZero
        bottom.position = CGPointZero
        bottom.size = CGSizeMake(viewSize.width, bottom.size.height * 0.5)
        bottom.zPosition = 5
        addChild(bottom)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
