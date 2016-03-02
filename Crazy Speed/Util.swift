import UIKit

let userDefaults = NSUserDefaults.standardUserDefaults()

let kCCOtherCarsCategory : UInt32 = 0x1 << 0
let kCCOurCarCategory : UInt32 = 0x1 << 1
let kCCBulletCategory : UInt32 = 0x1 << 2

let imageVector = ["pickup", "police", "sedan", "truck", "beetle"]
let font = "Damascus"

var viewSize: CGSize!
var totalAvailablePositions = [CGFloat()]
var lifes = 0 //vidas
var lastLane = 0
var mySideCarsSpeed = 120
var otherSideCarsSpeed = 300
var velocity = [CGVector()]

class Util {
    
    class func timeString(time: CFTimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        return String(format:"%02i:%02i",minutes,Int(seconds))
    }
    
    class func random(min: Int, max: Int) -> Int {
        let range : UInt32 = UInt32(max-min)
        let rand : Int = Int(arc4random_uniform(range)) + min
        
        return rand
    }
   
}
