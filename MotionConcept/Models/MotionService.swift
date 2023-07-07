//
//  MotionController.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 07/07/23.
//

import Foundation
import CoreMotion

protocol MotionServiceDelegate {
    func didUpdateAccelerometerData(_ motionManager: MotionService, data: String)
    func didUpdateMotionActivityData(_ motionManager: MotionService, data: String)
    func didUpdatePedometerData(_ motionManager: MotionService, data: String)
    func didFailedWithError(error: Error)
}

struct MotionService {
    
    var delegate: MotionServiceDelegate?
    
    // MARK: - CMMotionManager
    var motionManager = CMMotionManager()
    
    func initializeMotionManager() -> Void {
        motionManager.deviceMotionUpdateInterval = 0.1
        
        if(motionManager.isDeviceMotionAvailable) {
            print("Motion sensors are available")
            motionManager.startDeviceMotionUpdates(to: .main, withHandler: updateMotionData)
        } else {
            print("Motion sensors are not available")
        }
    }
    
    func updateMotionData(data: CMDeviceMotion?, error: Error?) -> Void {
        if(error != nil) {
            print("Error in motion: \(error)")
            return
        }
        if let safeData = data {
            // print("Magents: \(safeData.attitude) ")
            let accelerationData = AccelerationDataModel(userAccelerationX: safeData.userAcceleration.x, userAccelerationY: safeData.userAcceleration.y, userAccelerationZ: safeData.userAcceleration.z)
            let data: String = accelerationData.getLabel()
            delegate?.didUpdateAccelerometerData(self, data: data)
        }
    }
    
    // MARK: - CMMotionActivityManager
    var motionActivityManager = CMMotionActivityManager()
    
    func initializeMotionActivityManager() -> Void {
        if(CMMotionActivityManager.isActivityAvailable()) {
            print("Motion activity data is available")
            motionActivityManager.startActivityUpdates(to: .main, withHandler: updateMotionActivityData)
        } else {
            print("Motion activity data is not available")
        }
    }
    
    func updateMotionActivityData(data: CMMotionActivity?) -> Void {
        if let safeData = data {            
            let motionActivityData: MotionActivityDataModel = MotionActivityDataModel(confidence: safeData.confidence.rawValue, isStationary: safeData.stationary, isWalking: safeData.walking, isUnknown: safeData.unknown, isRunning: safeData.running, isAutomotive: safeData.automotive)
            delegate?.didUpdateMotionActivityData(self, data: motionActivityData.getLabel())
            
        } else {
            print("Error in motion activity")
        }
    }
    
    // MARK: - CMPedometer
    var pedometer = CMPedometer()
    
    func initializePedometer() -> Void {
        if(CMPedometer.isStepCountingAvailable()) {
            print("Pedometer is available")
            pedometer.startUpdates(from: Date(), withHandler: updatePedometerData)
        } else {
            print("Pedometer is not available")
        }
    }
    
    func updatePedometerData(data: CMPedometerData?, error: Error?) -> Void {
        if(error != nil) {
            print("Error in pedometer: \(error)")
            return
        }
        if let safeData = data {
            let pedometerData: PedometerDataModel = PedometerDataModel(numberOfSteps: safeData.numberOfSteps)
            delegate?.didUpdatePedometerData(self, data: pedometerData.getLabel())
        }
    }
    
    // MARK: - Stop Updates
    func stopAllUpdates() -> Void {
        motionManager.stopDeviceMotionUpdates()
        motionActivityManager.stopActivityUpdates()
        pedometer.stopUpdates()
    }
}
