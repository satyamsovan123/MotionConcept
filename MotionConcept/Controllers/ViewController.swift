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
    
    var accelerationDataManager = AccelerationDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager.accelerometerUpdateInterval = 0.1
        
        if(motionManager.isAccelerometerAvailable) {
             print("Accelerometer is available")
            speedLabel.text = "Do something, fool!"
            motionManager.startAccelerometerUpdates(to: .main, withHandler: updateAccelerometerData)
        } else {
            print("Accelerometer is not available")
            let randomNumber = Int.random(in: 2..<9)
            speedLabel.text = "I've searched \(randomNumber) times for an accelerometer, and never found one."
        }
    }

    func updateAccelerometerData(data: CMAccelerometerData?, error: Error?) -> Void {
        if let errorData: Error = error {
            print("Error: \(errorData)")
        }
        
        if let accelerometerData: CMAccelerometerData = data {
            let x: Double = accelerometerData.acceleration.x
            let y: Double = accelerometerData.acceleration.y
            let z: Double = accelerometerData.acceleration.z
            let rawAccelerationData = AccelerationDataModel(x: x, y: y, z: z)
            let convertedAccelerationValue = accelerationDataManager.convertToMeterPerSecondSquared(data: rawAccelerationData)
            
            print("Converted data: \(convertedAccelerationValue)")
            xLabel.text = "x " + String(format: "%.1f", convertedAccelerationValue.x) + "m/s²"
            yLabel.text = "y " + String(format: "%.1f", convertedAccelerationValue.y) + "m/s²"
            zLabel.text = "z " + String(format: "%.1f", convertedAccelerationValue.z) + "m/s²"
        }
    }
    
    func startDeviceMotionUpdates(to queue: OperationQueue, withHandler handler: @escaping CMDeviceMotionHandler) {
        
    }
    
    @IBAction func checkPressed(_ sender: UIButton) {
        print("Call backend")
        motionManager.stopAccelerometerUpdates()
        speedLabel.text = "खोज कर बताऊंगा"
    }
    
    deinit {
        print("Deinitializing: Stop receiving accelerometer data")
        motionManager.stopAccelerometerUpdates()
    }
    
}
