//
//  ViewController.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 06/07/23.
//

import UIKit
import CoreMotion


class ViewController: UIViewController {
    
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var sensorOutputLabel: UILabel!
    
    var motionManager = MotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager.initializeMotionManager()
        motionManager.initializeMotionActivityManager()
        motionManager.initializePedometer()
    }
    
    @IBAction func checkPressed(_ sender: UIButton) {
        print("Call backend")
        adviceLabel.text = "You're moving too fast!"
        motionManager.motionManager.stopDeviceMotionUpdates()
        motionManager.motionActivityManager.stopActivityUpdates()
        motionManager.stopAllUpdates()
    }
    
    deinit {
        print("Deinitializing: Stop receiving data")
        motionManager.stopAllUpdates()
    }
    
    
    
}
