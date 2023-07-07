//
//  DataModel.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 06/07/23.
//

import Foundation

struct AccelerationDataModel {
    let userAccelerationX: Double
    let userAccelerationY: Double
    let userAccelerationZ: Double
    
    private var rawNetAcceleration: Double {
        return calculateNetAcceleration()
    }
    private var formattedNetAcceleration: String {
        return formatData(rawNetAcceleration)
    }
    
    init(userAccelerationX: Double, userAccelerationY: Double, userAccelerationZ: Double) {
        self.userAccelerationX = userAccelerationX
        self.userAccelerationY = userAccelerationY
        self.userAccelerationZ = userAccelerationZ
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
    
    func getLabel() -> String {
        let sensorDataLabel: String = "You are accelerating \(formattedNetAcceleration) m/s²."
        return sensorDataLabel
    }
}
