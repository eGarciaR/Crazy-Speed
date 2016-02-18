import SpriteKit

class ButtonBoltNode: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "bolt")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.name = "bolt"
        self.position = position
        self.setScale(0.4)
        self.zPosition = 6
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}