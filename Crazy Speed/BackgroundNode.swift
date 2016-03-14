import SpriteKit

class BackgroundNode : SKNode {
    
    var bg1 : SKSpriteNode!
    var bg2 : SKSpriteNode!
    var speedBackground : CGFloat = 5
    
    override init() {
        super.init()

        bg1 = SKSpriteNode(imageNamed: "background")
        bg1.anchorPoint = CGPointZero
        bg1.position = CGPointZero
        bg1.size = viewSize
        addChild(bg1!)
        
        bg2 = SKSpriteNode(imageNamed: "background")
        bg2.anchorPoint = CGPointZero
        bg2.position = CGPointMake(0, bg1.size.height)
        bg2.size = viewSize
        addChild(bg2)
    }
    
    func move(){
        bg1.position = CGPointMake(bg1.position.x, bg1.position.y-speedBackground)
        bg2.position = CGPointMake(bg2.position.x, bg2.position.y-speedBackground)
        
        if bg1.position.y < -bg1.size.height {
            bg1.position = CGPointMake(bg1.position.x, bg2.position.y + bg2.size.height)
        }
        if bg2.position.y < -bg2.size.height {
            bg2.position = CGPointMake(bg2.position.x, bg1.position.y + bg1.size.height)
        }
    }
    
    func updateSpeed(){
        if speedBackground < 20 { speedBackground++ }
        print(speedBackground)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
