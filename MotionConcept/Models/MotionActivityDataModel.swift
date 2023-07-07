//
//  MotionActivityDataModel.swift
//  MotionConcept
//
//  Created by Satyam Sovan Mishra on 08/07/23.
//

import Foundation

struct MotionActivityDataModel {
    let confidence: Int
    let isStationary: Bool
    let isWalking: Bool
    let isUnknown: Bool
    let isRunning: Bool
    let isAutomotive: Bool
    
   private var motionType: String {
        return parseAction()
    }
    
    init(confidence: Int, isStationary: Bool, isWalking: Bool, isUnknown: Bool, isRunning: Bool, isAutomotive: Bool) {
        self.confidence = confidence
        self.isAutomotive = isAutomotive
        self.isRunning = isRunning
        self.isStationary = isStationary
        self.isUnknown = isUnknown
        self.isWalking = isWalking
    }
    
    private func parseAction() -> String {
        var action: String = ""
        switch (isAutomotive, isRunning, isStationary, isUnknown, isWalking) {
        case (false, false, false, false, true):
            action = "walking"
        case (false, false, false, true, false):
            action = "using this app"
        case (false, false, true, false, false):
            action = "still"
        case (false, true, false, false, false):
            action = "running"
        case (true, false, false, false, false):
            action = "in a vehicle"
        default:
            action = "doing something"
        }
        return action
    }
    
    private func getConfidenceLevel() -> String {
        var modalAdverb: String = ""
        switch (confidence) {
        case (0):
             modalAdverb = "Perhaps"
        case (1):
             modalAdverb = "Possibly"
        case (2):
             modalAdverb = "Definitely"
        default:
             modalAdverb = "Hmm"
        }
        return  modalAdverb
    }
    
    func getLabel() -> String {
        let sensorDataLabel: String = "\(getConfidenceLevel()), you are \(motionType)."
        return sensorDataLabel
    }
}
