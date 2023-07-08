//
//  ViewController.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 06/07/23.
//

import UIKit
import CoreMotion

// MARK: - UIViewController
class ViewController: UIViewController {
    
    @IBOutlet weak var sensorOutputLabel: UILabel!
    
    var motionService = MotionService()
    
    var pedometerLabel: String = ""
    var motionActivityLabel: String = ""
    var accelerometerLabel: String = ""
    var headphoneLabel: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionService.delegate = self
        motionService.initializeMotionManager()
        motionService.initializeMotionActivityManager()
        motionService.initializePedometer()
        motionService.initializeHeadPhoneMotionManager()
    }
    
    @IBAction func checkPressed(_ sender: UIButton) {
        // TODO: Call backend
        // TODO: Create a segue on press, display some data on the segued view
        // TODO: Create a websocket to accept key features
        motionService.stopAllUpdates()
    }
    
    deinit {
        print("Deinitializing: Stop receiving data")
        motionService.stopAllUpdates()
    }
    
    func updateLabel() {
        DispatchQueue.main.async {
            let label: String = "\(self.motionActivityLabel) \(self.accelerometerLabel) \(self.pedometerLabel) \(self.headphoneLabel)"
            // print(label)
            self.sensorOutputLabel.text = label
        }
    }
}

// MARK: - MotionServiceDelegate
extension ViewController: MotionServiceDelegate {
    func didUpdatePedometerData(_ motionManager: MotionService, data: String) {
        pedometerLabel = data
        updateLabel()
    }
    
    func didUpdateAccelerometerData(_ motionManager: MotionService, data: String) {
        accelerometerLabel = data
        updateLabel()
    }
    
    func didUpdateMotionActivityData(_ motionManager: MotionService, data: String) {
        motionActivityLabel = data
        updateLabel()
    }
    
    func didUpdateHeadphoneData(_ motionManager: MotionService, data: String) {
        headphoneLabel = data
        updateLabel()
    }
    
    func didFailedWithError(error: Error) {
        // TODO: Handle error
        print(error)
    }
}
