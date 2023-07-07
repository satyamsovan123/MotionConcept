//
//  MotionController.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 07/07/23.
//

import Foundation
import CoreMotion

protocol MotionManagerDelegate {
    func didUpdateMotionData(_ motionManager: MotionManager, motionData: MotionDataModel)
    func didFailedWithError(error: Error)
}

struct MotionManager {
    var motionManager = CMMotionManager()
    var motionActivityManager = CMMotionActivityManager()
    var pedometer = CMPedometer()
    
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
            let motionData = MotionDataModel(userAccelerationX: safeData.userAcceleration.x, userAccelerationY: safeData.userAcceleration.y, userAccelerationZ: safeData.userAcceleration.z)
            // print(motionData.getSensorDataLabel())
        }
    }
    
    func initializeMotionActivityManager() -> Void {
        if(CMMotionActivityManager.isActivityAvailable()) {
            print("Motion activity data is available")
            motionActivityManager.startActivityUpdates(to: .main, withHandler: updateMotionActivityData)
            print("okay")
        } else {
            print("Motion activity data is not available")
        }
    }
    
    func updateMotionActivityData(data: CMMotionActivity?) -> Void {
        if let safeData = data {
            DispatchQueue.main.async {
                print(safeData)
            }
        } else {
            print("Error in motion activity: ")
        }
    }
    
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
            print(safeData)
        }
    }
    
    func stopAllUpdates() -> Void {
        motionManager.stopDeviceMotionUpdates()
        motionActivityManager.stopActivityUpdates()
        pedometer.stopUpdates()
    }
}
