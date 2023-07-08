//
//  DataModel.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 06/07/23.
//

import Foundation

struct CustomMotionDataModel {
    let userAccelerationX: Double
    let userAccelerationY: Double
    let userAccelerationZ: Double
    
    let headphonePitch: Double
    let headphoneRoll: Double
    let headphoneYaw: Double
    
    var previousHeadphoneYaw: Double = 0.0
    var previousHeadphonePitch: Double = 0.0
    
    private var rawNetAcceleration: Double {
        return calculateNetAcceleration()
    }
    
    private var formattedNetAcceleration: String {
        return formatData(rawNetAcceleration)
    }
    
    init(userAccelerationX: Double, userAccelerationY: Double, userAccelerationZ: Double, headphonePitch: Double, headphoneRoll: Double, headphoneYaw: Double) {
        self.userAccelerationX = userAccelerationX
        self.userAccelerationY = userAccelerationY
        self.userAccelerationZ = userAccelerationZ
        self.headphonePitch = headphonePitch
        self.headphoneRoll = headphoneRoll
        self.headphoneYaw = headphoneYaw
    }
    
    private func calculateNetAcceleration() -> Double {
        let gravitationalConstant = 9.8
        
        let userAccelerationXInMetersPerSecondSquared = userAccelerationX * gravitationalConstant
        let userAccelerationYInMetersPerSecondSquared = userAccelerationY * gravitationalConstant
        let userAccelerationZInMetersPerSecondSquared = userAccelerationZ * gravitationalConstant
        let rawNetAcceleration: Double = sqrt(pow(userAccelerationXInMetersPerSecondSquared, 2) + pow(userAccelerationYInMetersPerSecondSquared, 2) + pow(userAccelerationZInMetersPerSecondSquared, 2))
        return rawNetAcceleration
    }
    
    private func formatData(_ rawData: Double) -> String {
        let formattedData: String = String(format: "%.2f", rawData)
        return formattedData
    }
    
    func getAccelerationLabel() -> String {
        let sensorDataLabel: String = "You are accelerating \(formattedNetAcceleration) m/s²."
        return sensorDataLabel
    }
    
    mutating func getHeadphoneAttitudeLabel() -> String {
        let sensorDataLabel: String = "\(formatData(headphonePitch))"
        print("P: \(formatData(headphonePitch)), OP: \(previousHeadphonePitch)") // Yes?
        previousHeadphonePitch = headphonePitch
        print("Diff: \(previousHeadphonePitch - headphonePitch)")
//        print("Y: \(formatData(headphoneYaw))") // No?
//        print("R: \(formatData(headphoneRoll))")
        return sensorDataLabel
    }
}
