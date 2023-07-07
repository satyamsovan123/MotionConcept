//
//  DataModel.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 06/07/23.
//

import Foundation

struct MotionDataModel {
    let userAccelerationX: Double
    let userAccelerationY: Double
    let userAccelerationZ: Double
    
    init(userAccelerationX: Double, userAccelerationY: Double, userAccelerationZ: Double) {
        self.userAccelerationX = userAccelerationX
        self.userAccelerationY = userAccelerationY
        self.userAccelerationZ = userAccelerationZ
    }
}
