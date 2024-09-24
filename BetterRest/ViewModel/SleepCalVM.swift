//
//  SleepCalVM.swift
//  BetterRest
//
//  Created by Muhammad Dzaky on 24/09/24.
//

import Combine
import CoreML
import SwiftUI


class SleepCalVM: ObservableObject {
    // Data Properties
    @Published var desiredSleepAmount = 8.0
    @Published var wakeUpTime = defaultWakeUpTime
    @Published var coffeeAmount = 1
    @Published var sleepRanges: [Double] = Array(stride(from: 4.0, to: 13.0, by: 1)) // Convert to an array
    
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    
    @Published var recommendationMessage: String = defaultWakeUpTime.formatted()
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    func calculateBedtime() {
        
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            // Predict actual sleep
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: desiredSleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUpTime - prediction.actualSleep
            
            recommendationMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
            alertTitle = "Your bedtime is"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            // if something went wrong
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showAlert = true
        }
    }
}


