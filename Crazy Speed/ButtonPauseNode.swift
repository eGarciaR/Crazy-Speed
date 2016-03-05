import SpriteKit

class ButtonPauseNode: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "pause")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.name = "pause"
        self.position = position
        self.setScale(0.4)
        self.zPosition = 6
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}