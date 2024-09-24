//
//  ContentView.swift
//  BetterRest
//
//  Created by Muhammad Dzaky on 23/09/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    // Data Properties
    @State private var sleepAmount = 8.0
    @State private var wakeUpTime = defaultWakeUpTime
    @State private var coffeeAmount = 1
    @State private var sleepRanges: [Double] = Array(stride(from: 4.0, to: 13.0, by: 1)) // Convert to an array
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    
    @State private var recommendationMessage: String = defaultWakeUpTime.formatted()
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment:.center, spacing: 20) {
                RecommendationCard(sleepTime: recommendationMessage)
                    .padding(.horizontal, 16)
                // Form Content
                Form {
                    Section {
                        HStack (alignment: .center) {
                            Text("Wake up time")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 8)
                            DatePicker("Please enter a time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .onChange(of: wakeUpTime) { newValue, _ in
                                    calculateBedtime()
                                }
                        }
                        HStack(alignment: .center, spacing: 12){
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Desired sleep amount:")
                                    .font(.subheadline)
                                Text("\(sleepAmount.formatted()) hours")
                                    .font(.headline)
                            }
                            Spacer()
                            Stepper("Desired Sleep Amount: \(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                                .labelsHidden()
                                .onChange(of: sleepAmount) { newValue, _ in
                                    calculateBedtime()
                                }
                        }
                        HStack (alignment: .center, spacing: 12) {
                            Text("Daily coffee intake")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 8)
                            Picker(selection: $coffeeAmount, label: Text("Coffee Intake")){
                                ForEach (1...20, id: \.self) {coffeeAmount in
                                    Text(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount.formatted()) cups")
                                }
                            }
                            .labelsHidden()
                            .onChange(of: coffeeAmount) { newValue, _ in
                                calculateBedtime()
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                }
                .scrollDisabled(true)
                .shadow(.elevation1)
                .scrollContentBackground(.hidden)
                .navigationTitle("Better Rest")
                .navigationBarTitleDisplayMode(.inline)
                .alert(alertTitle, isPresented: $showAlert){
                    Button("OK"){}
                } message: {
                    Text(alertMessage)
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .onAppear{
                calculateBedtime()
            }
        }
    }
    
    
    func calculateBedtime() {
        
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            // Predict actual sleep
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
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





struct RecommendationCard: View {
    var sleepTime: String
    var body: some View {
        // Recommendation Card
        VStack(alignment: .center, spacing: 8) {
            Text("Sleep Time")
                .font(.title3.weight(.medium))
                .foregroundStyle(.secondary)
            Text((sleepTime))
                .font(.title.weight(.semibold))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(.elevation1)
    }
}

#Preview {
    ContentView()
}


