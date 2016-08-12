import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var timeOfLastLife : CFAbsoluteTime?
    var timeTillNextLife : CFTimeInterval = CFTimeInterval(600)
    
    var timeOfLastShield : CFAbsoluteTime?
    var timeTillNextShield : CFTimeInterval = CFTimeInterval(600)
    
    var timeOfLastShotGun : CFAbsoluteTime?
    var timeTillNextShotGun : CFTimeInterval = CFTimeInterval(600)
    
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
    var btnPause : ButtonPauseNode?
    var car : CarNode?
    var otherCar : OtherCarNode?
    var gameStart : GameStartNode?
    var gameOver : GameOverNode?
    var pauseMenu : PauseMenuNode?
    var bullet : BulletNode?
    var transparentPauseNode : TransparentPauseNode?
    var shieldNode : ShieldBoosterNode?
    var shotGunNode : ShotGunBoosterNode?
    var settingsNode : SettingsNode?
    var storeNode : StoreNode?
    var carSelectionNode : CarSelectionNode?
    
    var highscore = 0 // mejor puntuacion
    var score = 0 // Distancia recorrida en metros
    var minSpeed = 0
    
    var isStarted = false
    var didTheGamePaused = false
    var boosterTouched = false
    var inSettings = false
    var inCarSelection = false
    var inStore = false
    var destroyed = false
    
    var shieldUp = false
    var shotGunUp = false
    var music = true
    var userCar = 0
    var boosterTime = 0
    var timerShield = NSTimer()
    var timerShotGun = NSTimer()
    
    var audioPlayer = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        viewSize = size
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameScene.saveGameData), name: "saveGameData", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameScene.pause), name: "pause", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GameScene.resume), name: "resume", object: nil)
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0) // Gravedad zero
        self.physicsWorld.contactDelegate = self
        
        totalAvailablePositions = [size.width*0.2, size.width*0.357, size.width*0.5, size.width*0.667, size.width*0.81]
        
        loadGameData()
        
        setupBackground()
        setupHUD()
        setupLabels()
        setupBtnPause()
        setupCar()
        setupStart()
        setupGameOver()
        setupBoosters()
        setupSettings()
        setupCarSelection()
        setupStore()
        setupSounds()
        setupTransparentPauseNode()
        setupShieldNode()
        setupShotGunNode()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let touchLocation = touch.locationInNode(self)
            let node = self.nodeAtPoint(touchLocation)
            
            if let name = node.name as String? {
                switch name {
                case "play":
                    playAction()
                    break
                case "load":
                    loadAction()
                    break
                case "pause":
                    if isStarted{pause()}
                case "transparentPauseNode": // Nodo "transparente" que permite acceder al botón de pausa más facilmente
                    if isStarted{pause()}
                    break
                case "resume":
                    if isStarted{resume()}
                    break
                case "shield":
                    shieldAction()
                    break
                case "shots":
                    shotsAction()
                    break
                case "returnMenu":
                    gameOver?.hide() {self.gameStart?.show()}
                    break
                case "quit":
                    quitAction()
                    break
                case "settings":
                    settingsAction()
                    break
                case "shop":
                    shopAction()
                    break
                case "mute":
                    music(true)
                    break
                case "noMute":
                    music(false)
                    break
                case "carSelection":
                    carSelectionAction()
                    break
                case "add5Lifes":
                    addBoughtLifes(5);
                    break
                case "add10Lifes":
                    addBoughtLifes(10);
                    break
                case "add20Lifes":
                    addBoughtLifes(20);
                    break
                case "add5Shield":
                    addBoughtShield(5);
                    break
                case "add10Shield":
                    addBoughtShield(10);
                    break
                case "add20Shield":
                    addBoughtShield(20);
                    break
                case "add5Shots":
                    addBoughtShots(5);
                    break
                case "add10Shots":
                    addBoughtShots(10);
                    break
                case "add20Shots":
                    addBoughtShots(20);
                    break
                case "viper":
                    setupUserCar(2)
                    break
                case "audiR8":
                    setupUserCar(3)
                    break
                case "camaro":
                    setupUserCar(0)
                    break
                case "formula1":
                    setupUserCar(1)
                    break
                default:
                    break
                }
            }
            
            if isStarted && !didTheGamePaused && !boosterTouched{
                car?.move(touchLocation.x, position: size.width/2)
            }
            boosterTouched = false
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        
        addLife()
        addShield() // booster
        addShotGun() // booster
        
        if isStarted && (!didTheGamePaused){
            background?.move()
            addCar(currentTime)
            updateCarTimeInterval(currentTime)
            updateScore(currentTime)
            increaseSpeed(currentTime)
            if shieldUp && boosterTime >= 15{
                boosterTime = 0
                turnOffShieldProtection()
            }
            if shotGunUp && boosterTime >= 37{ // boosterTime va en función del timeInterval
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
        self.enumerateChildNodesWithName("bullet", usingBlock: { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
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
            if !shieldUp {
                secondBody.node?.removeFromParent()
                destroyed = true
                isGameOver()
            }
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
            if (self.totalGameTime < 70) {
                mySideCarsSpeed += 4
                otherSideCarsSpeed += 4
            }
            else {
                mySideCarsSpeed += 8
                otherSideCarsSpeed += 8
            }
            
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
    
    func addBoughtLifes(lifesAdded: Int) {
        lifes += lifesAdded
        labels?.updateLifes(lifes)
        saveGameData()
    }
    
    func addShield() {
        let currentTimeAbsolute = CFAbsoluteTimeGetCurrent()
        
        if currentTimeAbsolute - timeOfLastShield! > timeTillNextShield {
            if qShield < 5 {
                let totalShields = Int((currentTimeAbsolute - timeOfLastShield!)/timeTillNextShield)
                qShield = (totalShields >= 5) ? 5 : min(5,qShield + totalShields)
                labels?.updateQuantityShield(qShield)
                saveGameData()
            }
            
            timeOfLastShield = CFAbsoluteTimeGetCurrent()
        }
    }
    
    func addBoughtShield(shieldsAdded: Int) {
        qShield += shieldsAdded
        labels?.updateQuantityShield(qShield)
        saveGameData()
    }
    
    func addShotGun() {
        let currentTimeAbsolute = CFAbsoluteTimeGetCurrent()
        
        if currentTimeAbsolute - timeOfLastShotGun! > timeTillNextShotGun {
            if qShotGun < 5 {
                let totalShots = Int((currentTimeAbsolute - timeOfLastShotGun!)/timeTillNextShotGun)
                qShotGun = (totalShots >= 5) ? 5 : min(5,qShotGun + totalShots)
                labels?.updateQuantityShotGun(qShotGun)
                saveGameData()
            }
            
            timeOfLastShotGun = CFAbsoluteTimeGetCurrent()
        }
    }
    
    func addBoughtShots(shotsAdded: Int) {
        qShotGun += shotsAdded
        labels?.updateQuantityShotGun(qShotGun)
        saveGameData()
    }
    
    func updateCarTimeInterval(currentTime: CFTimeInterval){
        if ((lastUpdateTimeInterval) != nil) { totalGameTime = totalGameTime + currentTime - lastUpdateTimeInterval! }
        if (self.totalGameTime > 150) {
            addCarTimeInterval = 0.2
        } else if (self.totalGameTime > 120) {
            addCarTimeInterval = 0.25
        } else if (self.totalGameTime > 80) {
            addCarTimeInterval = 0.3
        } else if (self.totalGameTime > 60) {
            addCarTimeInterval = 0.4
        } else if (self.totalGameTime > 45) {
            addCarTimeInterval = 0.65
        } else if (self.totalGameTime > 30) {
            addCarTimeInterval = 0.9
        } else if (self.totalGameTime > 15) {
            addCarTimeInterval = 1.2
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
        labels?.updateQuantityShield(qShield)
        labels?.updateQuantityShotGun(qShotGun)
        addChild(labels!)
    }
    
    func setupBtnPause(){
        btnPause = ButtonPauseNode(position: CGPointMake(size.width * 0.85, 20))
        addChild(btnPause!)
    }
    
    func setupCar() {
        car = CarNode(position: CGPointMake(self.size.width/2, self.size.height/6))
        car?.loadPhysicsBody()
        car?.texture = SKTexture(imageNamed: carVector[userCar])
        self.addChild(car!)
    }
    
    func setupStart(){
        gameStart = GameStartNode()
        gameStart?.timeNode.hidden = lifes >= 5
        addChild(gameStart!)
    }
    
    func setupGameOver(){
        gameOver = GameOverNode()
        addChild(gameOver!)
    }
    
    func setupBoosters(){
        pauseMenu = PauseMenuNode()
        addChild(pauseMenu!)
    }
    
    func setupSettings() {
        settingsNode = SettingsNode()
        addChild(settingsNode!)
        if music {settingsNode?.noMute()}
        else {settingsNode?.mute()}
    }
    
    func setupCarSelection() {
        carSelectionNode = CarSelectionNode()
        addChild(carSelectionNode!)
    }
    
    func setupStore() {
        storeNode = StoreNode()
        addChild(storeNode!)
    }
    
    func setupShieldProtection() {
        car!.activateShield()
        shieldUp = true
        boosterTime = 0
        timerShield = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameScene.countdown), userInfo: nil, repeats: true)
        qShield -= 1
        labels!.updateQuantityShield(qShield)
    }
    
    func setupShotsGun() {
        shotGunUp = true
        boosterTime = 0
        createShotGunNode()
        timerShotGun = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(GameScene.countdown), userInfo: nil, repeats: true)
        qShotGun -= 1
        labels!.updateQuantityShotGun(qShotGun)
    }
    
    func createShotGunNode() {
        bullet = BulletNode(position: CGPointMake((car?.position.x)!, (car?.position.y)!+30))
        bullet?.loadPhysicsBody()
        addChild(bullet!)
    }
    
    func turnOffShotGun() {
        shotGunUp = false
        timerShotGun.invalidate()
        self.enumerateChildNodesWithName("countdownNode", usingBlock: { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.removeFromParent()
        })
        labels?.hideCountdownNumbers()
    }
    
    func turnOffShieldProtection() {
        shieldUp = false
        car!.deactivateShield()
        timerShield.invalidate()
        self.enumerateChildNodesWithName("countdownNode", usingBlock: { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.removeFromParent()
        })
        labels?.hideCountdownNumbers()
    }
    
    func countdown() {
        if !paused {boosterTime += 1}
        if shieldUp {
            if boosterTime == 12 {
                labels?.showCountdownNumbers()
                labels?.updateCountdownNumbers(3)
            }
            else if boosterTime == 13 {
                labels?.updateCountdownNumbers(2)
            }
            else if boosterTime == 14 {
                labels?.updateCountdownNumbers(1)
            }
        }
        if shotGunUp {
            createShotGunNode()
            if boosterTime == 30 {
                labels?.showCountdownNumbers()
                labels?.updateCountdownNumbers(3)
            }
            else if boosterTime == 33 {
                labels?.updateCountdownNumbers(2)
            }
            else if boosterTime == 36 {
                labels?.updateCountdownNumbers(1)
            }
        }
    }
    
    func setupSounds(){
        let path = NSBundle.mainBundle().pathForResource("music8bits.mp3", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer = sound
            audioPlayer.numberOfLoops = -1 // Repetir infinitamente
            if music {sound.play()}
        } catch {
            // couldn't load file :(
        }
    }
    
    func setupTransparentPauseNode() {
        transparentPauseNode = TransparentPauseNode(position: CGPointMake(size.width * 0.85, 20))
        self.addChild(transparentPauseNode!)
    }
    
    func setupShieldNode() {
        //shieldNode = ShieldBoosterNode(position: CGPointMake(self.size.width/2+self.size.width/3+self.size.width/9, self.size.height/2))
        shieldNode = ShieldBoosterNode(position: CGPointMake(self.size.width*0.935, self.size.height/2))
        self.addChild(shieldNode!)
    }
    
    func setupShotGunNode() {
        shotGunNode = ShotGunBoosterNode(position: CGPointMake(self.size.width/16, self.size.height/2))
        self.addChild(shotGunNode!)
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
    
    func setupUserCar(name: Int) {
        car?.texture = SKTexture(imageNamed: carVector[name])
        saveGameData()
    }
    
    func music(value: Bool) {
        if value {
            audioPlayer.play()
            settingsNode?.noMute()
            music = true
            saveGameData()
        }
        else {
            audioPlayer.stop()
            settingsNode?.mute()
            music = false
            saveGameData()
        }
    }
    
    func pause() {
        self.paused = true
        didTheGamePaused = true
        if shotGunUp {timerShotGun.invalidate()} // Si el juego se pausa, hay que parar el timer del shot gun
        pauseMenu?.show()
        audioPlayer.volume = 0.2
    }
    
    func pauseWhenAppInterrupts() {
        // Si salimos de la app en settings o store no pausamos porque ya esta pausado
        if !inSettings && !inStore {pause()}
    }
    
    func resume() {
        if inSettings {
            inSettings = false
            settingsNode?.hide()
        }
        self.paused = false
        if shotGunUp {
            timerShotGun.invalidate() // Invalidamos el tiempo para parar todos los timers, para ser más precisos habría que crear una varible en el pause() que almacene el valor del tiempo para después volver a continuar desde el mismo tiempo.
            timerShotGun = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(GameScene.countdown), userInfo: nil, repeats: true)
        } // Si el juego se reanuda, hay que reinicializar el timer
        pauseMenu?.hide()
        audioPlayer.volume = 1.0
    }
    
    func isGameOver() {
        isStarted = false
        
        turnOffShotGun()
        
        lifes -= 1
        labels?.updateLifes(lifes)
        
        highscore = ((score+minSpeed) > highscore ) ? (score+minSpeed) : highscore
        labels?.updateBest(highscore)
        
        saveGameData()
        
        self.enumerateChildNodesWithName("otherCar", usingBlock: { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.removeFromParent()
        })
        self.enumerateChildNodesWithName("bullet", usingBlock: { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.removeFromParent()
        })
        
        gameOver?.show()
    }
    
    func gameFinish() {
        isStarted = false
        
        turnOffShotGun()
        
        saveGameData()
        
        self.enumerateChildNodesWithName("otherCar", usingBlock: { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.removeFromParent()
        })
        self.enumerateChildNodesWithName("bullet", usingBlock: { (node:SKNode, stop:UnsafeMutablePointer<ObjCBool>) -> Void in
            node.removeFromParent()
        })
    }
    
    func newGame() {
        isStarted = true
        
        if destroyed {
            setupCar()
            destroyed = false
        }
        
        mySideCarsSpeed = 120
        otherSideCarsSpeed = 300
        background?.speedBackground = 5
        car?.speedCar = 10
        
        timeSinceCarAdded = 0
        addCarTimeInterval = 1.5
        totalGameTime = 0
        audioPlayer.volume = 1.0 // Si se sale del menú de pausa o settings hay que volver a activar el volumen al empezar partida
        score = 0
    }
    
    func saveGameData() {
        userDefaults.setBool(true, forKey: "syncronized")
        userDefaults.setInteger(lifes, forKey: "lifes")
        userDefaults.setInteger(qShield, forKey: "shields")
        userDefaults.setInteger(qShotGun, forKey: "shots")
        userDefaults.setBool(music, forKey: "music")
        userDefaults.setInteger(highscore, forKey: "highscore")
        userDefaults.setObject(timeOfLastLife, forKey: "timeOfLastLife")
        userDefaults.setObject(timeOfLastShield, forKey: "timeOfLastShield")
        userDefaults.setObject(timeOfLastShotGun, forKey: "timeOfLastShotGun")
        userDefaults.setObject(userCar, forKey: "userCar")
        userDefaults.synchronize()
    }
    
    func loadGameData() {
        lifes = userDefaults.integerForKey("lifes")
        qShield = userDefaults.integerForKey("shields")
        qShotGun = userDefaults.integerForKey("shots")
        music = userDefaults.boolForKey("music")
        userCar = userDefaults.integerForKey("userCar")
        highscore = userDefaults.integerForKey("highscore")
        timeOfLastLife = userDefaults.objectForKey("timeOfLastLife") as? CFAbsoluteTime
        timeOfLastShield = userDefaults.objectForKey("timeOfLastShield") as? CFAbsoluteTime
        timeOfLastShotGun = userDefaults.objectForKey("timeOfLastShotGun") as? CFAbsoluteTime
        if timeOfLastLife == nil { timeOfLastLife = CFAbsoluteTimeGetCurrent() }
        if timeOfLastShield == nil { timeOfLastShield = CFAbsoluteTimeGetCurrent() }
        if timeOfLastShotGun == nil { timeOfLastShotGun = CFAbsoluteTimeGetCurrent() }
        
        let sync = userDefaults.boolForKey("syncronized")
        if !sync {
            lifes = 5
            qShield = 5
            qShotGun = 5
            music = true
            userCar = 0
            saveGameData()
        }
    }
    
    func playAction() {
        paused = false
        if lifes > 0 {
            gameStart?.hide(){ self.newGame() }
        }
    }
    
    func loadAction() {
        gameOver?.hide(){
            if lifes > 0 {self.newGame()}
            else {self.gameStart?.show()}
        }
    }
    
    func shieldAction() {
        if !shotGunUp && !shieldUp  && qShield > 0{ // Se comprueva que no haya ningún booster activado
            setupShieldProtection()
        }
        boosterTouched = true
    }
    
    func shotsAction() {
        if !shieldUp && !shotGunUp  && qShotGun > 0{ // Se comprueva que no haya ningún booster activado
            setupShotsGun()
        }
        boosterTouched = true
    }
    
    func settingsAction() {
        inSettings = true
        gameStart?.hide()
        self.settingsNode?.show()
    }
    
    func shopAction() {
        inStore = true
        gameStart?.hide()
        self.storeNode?.show()
    }
    
    func quitAction() {
        gameFinish()
        paused = false
        if inSettings {
            settingsNode?.hide()
            self.gameStart!.show()
            inSettings = false
        }
        else if inCarSelection {
            carSelectionNode!.hide()
            self.settingsNode?.show()
            inCarSelection = false
            inSettings = true
        }
        else if inStore {
            storeNode?.hide()
            self.gameStart?.show()
            inStore = false
        }
        else {
            pauseMenu?.hide() {
                self.gameStart!.show()
            }
            if shieldUp {turnOffShieldProtection()}
            else if shotGunUp {turnOffShotGun()}
        }
    }
    
    func carSelectionAction() {
        inCarSelection = true
        self.settingsNode?.hide()
        inSettings = false
        self.carSelectionNode?.show()
    }
    
}
