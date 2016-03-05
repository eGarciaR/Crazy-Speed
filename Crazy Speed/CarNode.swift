import SpriteKit

class CarNode: SKSpriteNode {
    
    var carPosition = 2
    var speedCar = 10
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "car")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        self.name = "Car"
        self.position = position
        if UIScreen.mainScreen().bounds.width <= 420 {self.setScale(0.25)}
        else {self.setScale(0.4)}
    }
    
    func loadPhysicsBody(){
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.size.width, self.size.height))
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.linearDamping = 0.0
        self.physicsBody?.mass = 0.0
        self.physicsBody?.friction = 0.0
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.dynamic = false
        self.zPosition = 2
        self.physicsBody?.categoryBitMask = kCCOurCarCategory
        self.physicsBody?.contactTestBitMask = kCCOtherCarsCategory
    }
    
    func updateSpeed(speed: Int){
        speedCar += speed
    }
    
    func activateShield() {
        if UIScreen.mainScreen().bounds.width <= 420 {self.setScale(0.4)}
        else {self.setScale(0.6)}
    }
    
    func deactivateShield() {
        if UIScreen.mainScreen().bounds.width <= 420 {self.setScale(0.25)}
        else {self.setScale(0.35)}
    }
    
    func move(location: CGFloat, position: CGFloat){
        if location < position { moveLeft() }
        if location > position { moveRight() }
    }
    
    private func moveLeft() {
        if carPosition > 0 {
            --carPosition
            let moveAction = SKAction.moveToX(totalAvailablePositions[carPosition], duration: 0.3)
            self.runAction(moveAction)
        }
    }
    
    private func moveRight() {
        if carPosition < 4 {
            ++carPosition
            let moveAction = SKAction.moveToX(totalAvailablePositions[carPosition], duration: 0.3)
            self.runAction(moveAction)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}