//
//  UserInputView.swift
//  BetterRest
//
//  Created by Muhammad Dzaky on 24/09/24.
//

import SwiftUI

struct UserInputView: View {
    @ObservedObject var sleepModel = SleepCalVM()
    
    var body: some View {
        VStack (alignment: .center, spacing: 16) {
            WakeUpPicker(wakeUpTime: $sleepModel.wakeUpTime, onChange: sleepModel.calculateBedtime)
            Divider()
            SleepAmountPicker(desiredSleepAmount: $sleepModel.desiredSleepAmount, onChange: sleepModel.calculateBedtime)
            Divider()
            CoffeeIntakePicker(coffeeAmount: $sleepModel.coffeeAmount, onChange: sleepModel.calculateBedtime)

        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(.elevation1)
    }
}


#Preview {
    UserInputView()
}


