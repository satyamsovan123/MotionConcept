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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motionService.delegate = self
        motionService.initializeMotionManager()
        motionService.initializeMotionActivityManager()
        motionService.initializePedometer()
    }
    
    @IBAction func checkPressed(_ sender: UIButton) {
        // TODO: Call backed
        motionService.stopAllUpdates()
    }
    
    deinit {
        print("Deinitializing: Stop receiving data")
        motionService.stopAllUpdates()
    }
    
    func updateLabel() {
        DispatchQueue.main.async {
            let label: String = "\(self.motionActivityLabel) \(self.accelerometerLabel) \(self.pedometerLabel)"
            print(label)
            self.sensorOutputLabel.text = label
            
        }
    }
}

// MARK: - MotionServiceDelegate
extension ViewController: MotionServiceDelegate {
    func didUpdatePedometerData(_ motionManager: MotionService, data: String) {
        // TODO: Update UI
        pedometerLabel = data
        updateLabel()
    }
    
    func didUpdateAccelerometerData(_ motionManager: MotionService, data: String) {
        // TODO: Update UI
        accelerometerLabel = data
        updateLabel()
    }
    
    func didUpdateMotionActivityData(_ motionManager: MotionService, data: String) {
        // TODO: Update UI
        motionActivityLabel = data
        updateLabel()
    }
    
    func didFailedWithError(error: Error) {
        // TODO: Handle error
        print(error)
    }
}
