//
//  CoffeeIntakePicker.swift
//  BetterRest
//
//  Created by Muhammad Dzaky on 24/09/24.
//

import SwiftUI

struct CoffeeIntakePicker: View {
    @Binding var coffeeAmount: Int
    var onChange: () -> Void
    
    var body: some View {
        VStack (alignment: .center, spacing: 6) {
            HStack{
                Text("Daily coffee intake")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(coffeeAmount == 1 ? "1 cup" :"\(coffeeAmount) cups")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            Slider(value: Binding(get: {Double(coffeeAmount)}, set: {coffeeAmount = Int($0)}), in: 1...20, step: 1)
                .onChange(of: coffeeAmount) { newValue, _ in
                    onChange()
                }
        }
    }
}

#Preview {
    CoffeeIntakePicker(coffeeAmount: .constant(1), onChange: {})
}
