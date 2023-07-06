//
//  DataModel.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 06/07/23.
//

import Foundation

struct AccelerationDataModel {
    let x: Double
    let y: Double
    let z: Double
    
    init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
}
