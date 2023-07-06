//
//  AccelerationDataManager.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 06/07/23.
//

import Foundation

struct AccelerationDataManager {
    
    func convertToMeterPerSecondSquared(data: AccelerationDataModel) -> AccelerationDataModel {
        let accelerationInMeterPerSecondSquared: AccelerationDataModel = AccelerationDataModel(x: data.x * 9.8, y: data.y * 9.8, z: data.z * 9.8)
        return accelerationInMeterPerSecondSquared
    }
}
