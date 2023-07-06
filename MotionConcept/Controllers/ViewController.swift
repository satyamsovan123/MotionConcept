//
//  ViewController.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 06/07/23.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    
    var motionManager = CMMotionManager()
    
    var motionDataManager = MotionDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager.deviceMotionUpdateInterval = 0.1
        
        if(motionManager.isDeviceMotionAvailable) {
             print("Motion sensors are available")
            speedLabel.text = "Do something, fool!"
            motionManager.startDeviceMotionUpdates(to: .main, withHandler: updateMotionData)
        } else {
            print("Motion sensors are not available")
            let randomNumber = Int.random(in: 2..<9)
            speedLabel.text = "I've searched \(randomNumber) times for any motion sensors, and I never found one."
        }
    }

    func updateMotionData(data: CMDeviceMotion?, error: Error?) -> Void {
        if let errorData: Error = error {
            print("Error: \(errorData)")
        }
        print(data)
        
    }
    
//    func startDeviceMotiosnUpdates() {
//        

    @IBAction func checkPressed(_ sender: UIButton) {
        print("Call backend")
        motionManager.stopAccelerometerUpdates()
        speedLabel.text = "खोज कर बताऊंगा"
    }
    
    deinit {
        print("Deinitializing: Stop receiving accelerometer data")
        motionManager.stopDeviceMotionUpdates()
    }
    
}
