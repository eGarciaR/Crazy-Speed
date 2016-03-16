import SpriteKit

class LabelsNode : SKNode {
    var lifes: SKLabelNode!
    var score: SKLabelNode!
    var best: SKLabelNode!
    var quantityShield: SKLabelNode!
    var quantityShot: SKLabelNode!
    var countdownNumbers: SKLabelNode!
    
    override init() {
        super.init()
        
        let fontSize = CGFloat(viewSize.width / 18.75)
        
        lifes = SKLabelNode(fontNamed: font)
        lifes.text = "Lifes: 0"
        lifes.fontSize = fontSize
        lifes.position = CGPointMake(viewSize.width * 0.2, viewSize.height - 20)
        lifes.zPosition = 6
        lifes.verticalAlignmentMode = .Center
        lifes.horizontalAlignmentMode = .Center
        addChild(lifes)
        
        score = SKLabelNode(fontNamed: font)
        score.text = "Score: 0m"
        score.fontSize = fontSize
        score.position = CGPointMake(viewSize.width * 0.60, viewSize.height - 20)
        score.zPosition = 6
        score.verticalAlignmentMode = .Center
        score.horizontalAlignmentMode = .Left
        addChild(score)
        
        best = SKLabelNode(fontNamed: font)
        best.text = "Best: 0m"
        best.fontSize = fontSize
        best.position = CGPointMake(viewSize.width * 0.2, 20)
        best.zPosition = 6
        best.verticalAlignmentMode = .Center
        best.horizontalAlignmentMode = .Center
        addChild(best)
        
        quantityShield = SKLabelNode(fontNamed: font)
        quantityShield.fontSize = CGFloat(fontSize)
        quantityShield.fontColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        quantityShield.position = CGPointMake(viewSize.width*0.94, viewSize.height/2-viewSize.height/14)
        quantityShield.zPosition = 6
        addChild(quantityShield)
        
        quantityShot = SKLabelNode(fontNamed: font)
        quantityShot.fontSize = CGFloat(fontSize)
        quantityShot.fontColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        quantityShot.position = CGPointMake(viewSize.width*0.06, viewSize.height/2-viewSize.height/14)
        quantityShot.zPosition = 6
        addChild(quantityShot)
        
        countdownNumbers = SKLabelNode(fontNamed: font)
        countdownNumbers.fontSize = viewSize.width/2
        //countdownNumbers.fontColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        countdownNumbers.position = CGPointMake(viewSize.width/2, viewSize.height*0.4)
        countdownNumbers.zPosition = 6
        addChild(countdownNumbers)
        countdownNumbers.hidden = true
    }
    
    func hideCountdownNumbers() {
        countdownNumbers.hidden = true
    }
    
    func showCountdownNumbers() {
        countdownNumbers.hidden = false
    }
    
    func updateCountdownNumbers(n: Int) {
        countdownNumbers.text = String(n)
    }
    
    func updateLifes(n: Int) {
        lifes.text = "Lifes: \(String(n))"
    }
    
    func updateScore(n: Int){
        score.text = "Score: \(String(n))m"
    }
    
    func updateBest(n: Int){
        best.text = "Best: \(String(n))m"
    }
    
    func updateQuantityShield(n: Int) {
        quantityShield.text = String(n)
    }
    
    func updateQuantityShotGun(n: Int) {
        quantityShot.text = String(n)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
