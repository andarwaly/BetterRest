//
//  WakeUpPicker.swift
//  BetterRest
//
//  Created by Muhammad Dzaky on 24/09/24.
//

import SwiftUI

struct WakeUpPicker: View {
    @Binding var wakeUpTime: Date
    var onChange: () -> Void
    
    var body: some View {
        HStack (alignment: .center, spacing: 24) {
            VStack (alignment: .leading, spacing: 6) {
                Text("Wake up time")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Your desired wake up time")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            Spacer()
            DatePicker("Please enter a time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .onChange(of: wakeUpTime) { newValue, _ in
                    onChange()
                }
        }
    }
}

#Preview {
    WakeUpPicker(wakeUpTime: .constant(Date()), onChange: {})
}
