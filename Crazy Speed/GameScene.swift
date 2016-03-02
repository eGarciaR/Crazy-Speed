import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var timeOfLastLife : CFAbsoluteTime?
    var timeTillNextLife : CFTimeInterval = CFTimeInterval(600)
    
    var totalGameTime : CFTimeInterval = 0
    var lastUpdateTimeInterval : CFTimeInterval?
    
    var timeSinceCarAdded : CFTimeInterval = 0
    var addCarTimeInterval : CFTimeInterval = 1.5
    
    var timeSinceSpeedIncrease : CFTimeInterval = 0
    var increaseSpeedTimeInterval : CFTimeInterval = 0.5
    
    var timeSinceScoreUpdate : CFTimeInterval = 0
    var updateScoreTimeInterval : CFTimeInterval = 1
    
    var background : BackgroundNode?
    var labels : LabelsNode?
    var btnBolt : ButtonBoltNode?
    //var btnResume : BoostersNode?
    var car : CarNode?
    var otherCar : OtherCarNode?
    var gameStart : GameStartNode?
    var gameOver : GameOverNode?
    var boosters : BoostersNode?
    var progress : ProgressNode?
    var blackBullet : BlackBulletNode?
    
    var highscore = 0 // mejor puntuacion
    var score = 0 // Distancia recorrida en metros
    var minSpeed = 0
    
    var isStarted = false
    var didTheGamePaused = false
    
    var shieldUp = false
    var shotGunUp = false
    var boosterTime = 0
    var timerShield = NSTimer()
    var timerShotGun = NSTimer()
    
    
    override func didMoveToView(view: SKView) {
        viewSize = size
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveGameData", name: "saveGameData", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pause", name: "pause", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resume", name: "resume", object: nil)
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0) // Gravedad zero
        self.physicsWorld.contactDelegate = self
        
        totalAvailablePositions = [size.width*0.2, size.width*0.357, size.width*0.5, size.width*0.667, size.width*0.8]
        
        loadGameData()
        
        setupBackground()
        setupHUD()
        setupLabels()
        setupBtnBolt()
        setupCar()
        setupStart()
        setupGameOver()
        setupBoosters()
        setupProgress()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.locationInNode(self)
            let node = self.nodeAtPoint(touchLocation)
            
            if let name = node.name as String? {
                switch name {
                case "play":
                    if lifes > 0 {
                        gameStart?.hide(){ self.newGame() }
                    }
                case "load":
                    gameOver?.hide(){
                        //self.gameStart?.show()
                        if lifes > 0 {
                            self.newGame()
                        }
                        else {
                            self.gameStart?.show()
                            //Indicar que no tiene vidas
                        }
                    }
                case "bolt":
                    if isStarted{pause()}
                case "resume":
                    if isStarted{resume()}
                case "shield":
                    setupShieldProtection()
                    resume()
                case "shots":
                    setupShotsGun()
                    resume()
                case "returnMenu":
                    gameOver?.hide() {
                        self.gameStart?.show()
                    }
                default:
                    break
                }
            }
            
            if isStarted && !didTheGamePaused{
                car?.move(touchLocation.x, position: size.width/2)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
        addLife()
        
        if isStarted {
            background?.move()
            addCar(currentTime)
            updateCarTimeInterval(currentTime)
            updateScore(currentTime)
            increaseSpeed(currentTime)
            if shieldUp && boosterTime >= 15{
                boosterTime = 0
                turnOffShieldProtection()
            }
            if shotGunUp && boosterTime >= 75{
                boosterTime = 0
                turnOffShotGun()
            }
        }
        
        if !self.paused {didTheGamePaused = false}
        
        lastUpdateTimeInterval = currentTime
    }
    
    override func didSimulatePhysics() {
        self.enumerateChildNodesWithName("otherCar", usingBlock: { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            if node.position.y + node.frame.size.height < 0 {
                node.removeFromParent()
            }
            
        })
        self.enumerateChildNodesWithName("BlackBullet", usingBlock: { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            if node.position.y + node.frame.size.height < 0 {
                node.removeFromParent()
            }
            
        })
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == kCCOtherCarsCategory && secondBody.categoryBitMask == kCCOurCarCategory {
            self.addExplosion(firstBody.node!.position)
            firstBody.node?.removeFromParent()
            if !shieldUp {isGameOver()}
        }
        if firstBody.categoryBitMask == kCCOtherCarsCategory && secondBody.categoryBitMask == kCCBulletCategory {
            if firstBody.node != nil { self.addExplosion(firstBody.node!.position)} // Hay que mirar que el nodo no sea nulo.
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
    }
    
    func updateScore(currentTime: CFTimeInterval) {
        if ((lastUpdateTimeInterval) != nil) { timeSinceScoreUpdate = timeSinceScoreUpdate + currentTime - lastUpdateTimeInterval! }
        
        if (timeSinceScoreUpdate > updateScoreTimeInterval) {
            score += car!.speedCar
            timeSinceScoreUpdate = 0
        }

        minSpeed = Int( CGFloat(car!.speedCar) * CGFloat(timeSinceScoreUpdate))
        //score += minSpeed
        labels!.updateScore(score +  minSpeed)
    }
    
    func increaseSpeed(currentTime: CFTimeInterval) {
        if ((lastUpdateTimeInterval) != nil) { timeSinceSpeedIncrease = timeSinceSpeedIncrease + currentTime - lastUpdateTimeInterval! }
        
        if (timeSinceSpeedIncrease > increaseSpeedTimeInterval) {
            //print("increaseSpeed: \(increaseSpeedTimeInterval)")
            car?.updateSpeed(1)
            if car!.speedCar%10 == 0 { background?.updateSpeed() }
            mySideCarsSpeed += 2
            otherSideCarsSpeed += 2
            
            timeSinceSpeedIncrease = 0
        }
    }
    
    func addCar(currentTime: CFTimeInterval){
        if ((lastUpdateTimeInterval) != nil) { timeSinceCarAdded = timeSinceCarAdded + currentTime - lastUpdateTimeInterval! }
        
        if (timeSinceCarAdded > addCarTimeInterval) {
            //print("addCar: \(addCarTimeInterval)")
            
            let mySideCar = OtherCarNode(mySide: true)
            mySideCar.loadPhysicsBody(CGFloat(mySideCarsSpeed))
            addChild(mySideCar)
            
            let otherSideCar = OtherCarNode(mySide: false)
            otherSideCar.loadPhysicsBody(CGFloat(otherSideCarsSpeed))
            addChild(otherSideCar)
            
            timeSinceCarAdded = 0
        }
    }
    
    func addLife(){
        let currentTimeAbsolute = CFAbsoluteTimeGetCurrent()
        
        gameStart!.updateTime(timeTillNextLife - (currentTimeAbsolute - timeOfLastLife! ))
        
        if currentTimeAbsolute - timeOfLastLife! > timeTillNextLife {
            if lifes < 5 {
                let totalLifes = Int((currentTimeAbsolute - timeOfLastLife!)/timeTillNextLife)
                lifes = (totalLifes >= 5) ? 5 : min(5,lifes + totalLifes)
                labels?.updateLifes(lifes)
                saveGameData()
                
                gameStart?.timeNode.hidden = lifes >= 5
                
                //print("lifes added: \(totalLifes)")
            }
            
            timeOfLastLife = CFAbsoluteTimeGetCurrent()
        }
    }
    
    func updateCarTimeInterval(currentTime: CFTimeInterval){
        if ((lastUpdateTimeInterval) != nil) { totalGameTime = totalGameTime + currentTime - lastUpdateTimeInterval! }
        
        if ( self.totalGameTime > 60) {
            addCarTimeInterval = 0.5
        } else if (self.totalGameTime > 45) {
            addCarTimeInterval = 0.75
        } else if (self.totalGameTime > 30) {
            addCarTimeInterval = 1.0
        } else if (self.totalGameTime > 15) {
            addCarTimeInterval = 1.25
        }
    }
    
    func setupBackground(){
        background = BackgroundNode()
        addChild(background!)
    }
    
    func setupHUD(){
        let hud = HUDNode()
        addChild(hud)
    }
    
    func setupLabels() {
        labels = LabelsNode()
        labels?.updateLifes(lifes)
        labels?.updateBest(highscore)
        addChild(labels!)
    }
    
    func setupBtnBolt(){
        btnBolt = ButtonBoltNode(position: CGPointMake(size.width * 0.80, 20))
        addChild(btnBolt!)
    }
    
    func setupCar() {
        car = CarNode(position: CGPointMake(self.size.width/2, 100))
        car?.loadPhysicsBody()
        self.addChild(car!)
    }
    
    func setupStart(){
        gameStart = GameStartNode()
        gameStart?.timeNode.hidden = lifes != 0
        addChild(gameStart!)
    }
    
    func setupGameOver(){
        gameOver = GameOverNode()
        addChild(gameOver!)
    }
    
    func setupBoosters(){
        boosters = BoostersNode()
        addChild(boosters!)
    }
    
    func setupProgress(){
        progress = ProgressNode()
        progress?.radius = 40.0
        progress?.width = 8.0
        progress?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        progress?.hidden = true
        addChild(progress!)
    }
    
    func setupShieldProtection() {
        car!.activateShield()
        shieldUp = true
        boosterTime = 0
        timerShield = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("countdown"), userInfo: nil, repeats: true)
    }
    
    func setupShotsGun() {
        shotGunUp = true
        boosterTime = 0
        timerShotGun = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("countdown"), userInfo: nil, repeats: true)
    }
    
    func createShotGunNode() {
        blackBullet = BlackBulletNode(position: CGPointMake((car?.position.x)!, (car?.position.y)!+30))
        blackBullet?.loadPhysicsBody()
        addChild(blackBullet!)
    }
    
    func turnOffShotGun() {
        shotGunUp = false
        timerShotGun.invalidate()
    }
    
    func turnOffShieldProtection() {
        shieldUp = false
        car!.deactivateShield()
        timerShield.invalidate()
    }
    
    func countdown() {
        boosterTime++
        if shotGunUp {
            createShotGunNode()
        }
    }
    
    func setupSounds(){
        
    }
    
    func addExplosion(position: CGPoint) {
        
        let explosionPath = NSBundle.mainBundle().pathForResource("CarExplosion", ofType: "sks")
        let explosion = NSKeyedUnarchiver.unarchiveObjectWithFile(explosionPath!) as! SKEmitterNode
        explosion.position = position
        explosion.zPosition = 6
        self.addChild(explosion)
        
        let removeExplosion = SKAction.sequence([
            SKAction.waitForDuration(1.5),
            SKAction.removeFromParent()
            ])
        explosion.runAction(removeExplosion)
    }
    
    func pause() {
        self.paused = true
        didTheGamePaused = true
        
        boosters?.show()
    }
    
    func resume() {
        self.paused = false
        
        boosters?.hide()
    }
    
    func isGameOver() {
        isStarted = false
        
        lifes--
        labels?.updateLifes(lifes)
        
        highscore = ((score+minSpeed) > highscore ) ? (score+minSpeed) : highscore
        labels?.updateBest(highscore)
        
        saveGameData()
        
        self.enumerateChildNodesWithName("otherCar", usingBlock: { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.removeFromParent()
        })
        
        gameOver?.show()
    }
    
    func newGame() {
        isStarted = true
        
        mySideCarsSpeed = 120
        otherSideCarsSpeed = 300
        background?.speedBackground = 5
        car?.speedCar = 10
        
        timeSinceCarAdded = 0
        addCarTimeInterval = 1.5
        totalGameTime = 0
        
        score = 0
    }
    
    func saveGameData() {
        //print("saveGameData")
        userDefaults.setBool(true, forKey: "syncronized")
        userDefaults.setInteger(lifes, forKey: "lifes")
        userDefaults.setInteger(highscore, forKey: "highscore")
        userDefaults.setObject(timeOfLastLife, forKey: "timeOfLastLife")
        userDefaults.synchronize()
    }
    
    func loadGameData() {
        //print("loadGameData")
        lifes = userDefaults.integerForKey("lifes")
        highscore = userDefaults.integerForKey("highscore")
        timeOfLastLife = userDefaults.objectForKey("timeOfLastLife") as? CFAbsoluteTime
        if timeOfLastLife == nil { timeOfLastLife = CFAbsoluteTimeGetCurrent() }
        
        let sync = userDefaults.boolForKey("syncronized")
        if !sync {
            lifes = 5
            saveGameData()
        }
    }
    
    func loadProgress(){
        //print("loadProgress")
        self.physicsWorld.speed = 0.0
        progress?.hidden = false
        progress?.countdown(3.0) { () -> Void in
            self.progress?.hidden = true
            self.physicsWorld.speed = 1.0
            self.isStarted = true
        }
    }
    
}
