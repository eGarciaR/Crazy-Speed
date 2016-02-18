import SpriteKit

class LabelsNode : SKNode {
    var lifes: SKLabelNode!
    var score: SKLabelNode!
    var best: SKLabelNode!
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
