//
//  PedometerDataModel.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 08/07/23.
//

import Foundation

struct PedometerDataModel {
    let numberOfSteps: NSNumber
    
    private var formattedNumberOfSteps: String {
        return formatData(numberOfSteps)
    }
    
    init(numberOfSteps: NSNumber) {
        self.numberOfSteps = numberOfSteps
    }
    
    private func formatData(_ rawData: NSNumber) -> String {
        return String(describing: rawData)
    }
    
    func getLabel() -> String {
        let sensorDataLabel: String = "You have moved \(formattedNumberOfSteps) steps yet."
        return sensorDataLabel
    }

}
