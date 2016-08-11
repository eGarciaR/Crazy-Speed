import SpriteKit

class CarNode: SKSpriteNode {
    
    var carPosition = 2
    var speedCar = 10
    
    init(position: CGPoint) {
        let image = arc4random_uniform(4) // 0, 1 or 2
        let viper = SKTexture(imageNamed: "viper")
        let audiR8 = SKTexture(imageNamed: "audiR8")
        let camaro = SKTexture(imageNamed: "car")
        let formula1 = SKTexture(imageNamed: "formula1")
        if image == 0 {
            super.init(texture: viper, color: UIColor.clearColor(), size: viper.size())
        }
        else if image == 1 {
            super.init(texture: audiR8, color: UIColor.clearColor(), size: audiR8.size())
        }
        else if image == 2 {
            super.init(texture: formula1, color: UIColor.clearColor(), size: formula1.size())
        }
        else {
            super.init(texture: camaro, color: UIColor.clearColor(), size: camaro.size())
        }
        
        self.name = "Car"
        self.position = position
        if UIScreen.mainScreen().bounds.width <= 420 {
            if image == 2 || image == 0 {
                self.setScale(0.30)
            }
            else {
                self.setScale(0.25)
            }
        }
        else {
            if image == 2 || image == 0 {
                self.setScale(0.45)
            }
            else {
                self.setScale(0.4)
            }
        }
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
            carPosition -= 1
            let moveAction = SKAction.moveToX(totalAvailablePositions[carPosition], duration: 0.3)
            self.runAction(moveAction)
        }
    }
    
    private func moveRight() {
        if carPosition < 4 {
            carPosition += 1
            let moveAction = SKAction.moveToX(totalAvailablePositions[carPosition], duration: 0.3)
            self.runAction(moveAction)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}