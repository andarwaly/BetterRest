//
//  Untitled.swift
//  BetterRest
//
//  Created by Muhammad Dzaky on 24/09/24.
//

import SwiftUI

struct SleepAmountPicker: View {
    @Binding var desiredSleepAmount: Double
    var onChange: () -> Void
    
    var body: some View {
        HStack(alignment: .center, spacing: 24){
            VStack(alignment: .leading, spacing: 6) {
                Text("Sleep amount")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.primary)
                Text("\(desiredSleepAmount.formatted()) hours")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Stepper("Desired Sleep Amount: \(desiredSleepAmount.formatted()) hours", value: $desiredSleepAmount, in: 4...12, step: 0.25)
                .labelsHidden()
                .onChange(of: desiredSleepAmount) { newValue, _ in
                    onChange()
                   
                }
        }
    }
}


#Preview {
    SleepAmountPicker(desiredSleepAmount: .constant(4), onChange: {})
}
