import SpriteKit

class OtherCarNode: SKSpriteNode {
    
    var carPosition = 0
    
    init(mySide: Bool) {
        let texture = SKTexture(imageNamed: imageVector[Util.random(0, max: 5)])
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        if (mySide) {
            carPosition = Util.random(2, max: 5)
            if lastLane == carPosition { carPosition = Util.random(2, max: 5) }
            lastLane = carPosition
        }else{
            carPosition = Util.random(0, max: 2)
            self.zRotation = CGFloat(M_PI)
        }
        
        self.name = "otherCar"
        if UIScreen.mainScreen().bounds.width <= 420 {self.setScale(0.35)}
        else {self.setScale(0.45)}
        self.position = CGPointMake(totalAvailablePositions[carPosition], viewSize.height + (texture.size().height/2))
        self.zPosition = 3
    }
    
    func loadPhysicsBody(speedCar: CGFloat){
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width, self.size.height))
        self.physicsBody?.velocity = CGVectorMake(0, -speedCar)
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.friction = 0.0
        self.physicsBody?.mass = 0.0
        self.physicsBody?.categoryBitMask = kCCOtherCarsCategory
        self.physicsBody?.collisionBitMask = kCCOurCarCategory | kCCBulletCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}