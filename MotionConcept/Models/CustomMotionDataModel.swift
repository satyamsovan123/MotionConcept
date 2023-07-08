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
        var sensorDataLabel: String = "Possibly you said"
        let differenceInPitch: Double = abs(previousHeadphonePitch - headphonePitch)
        let pitchRange: ClosedRange<Double> = -0.9 ... 0.3
        let pitchDifferenceRange: ClosedRange<Double> = 0.3 ... 0.9
        let computedYes: Bool = ((pitchRange.contains(headphonePitch)) && (pitchDifferenceRange.contains(differenceInPitch)))

        let differenceInYaw: Double = abs(previousHeadphoneYaw - headphoneYaw)
        let yawRange: ClosedRange<Double> = -1 ... 1
        let yawDifferenceRange: ClosedRange<Double> = 0.1 ... 0.8
        let computedNo: Bool = ((yawRange.contains(headphoneYaw)) && (yawDifferenceRange.contains(differenceInYaw)))
        
        if(computedYes == true) {
            sensorDataLabel = "\(sensorDataLabel) yes."
        } else if(computedNo == true) {
            sensorDataLabel = "\(sensorDataLabel) no."
        } else {
            sensorDataLabel = "\(sensorDataLabel) nothing."
        }

        previousHeadphonePitch = headphonePitch
        previousHeadphoneYaw = headphoneYaw
        return sensorDataLabel
    }
}
