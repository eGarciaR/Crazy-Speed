import SpriteKit

class ButtonShopNode: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "shop")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}