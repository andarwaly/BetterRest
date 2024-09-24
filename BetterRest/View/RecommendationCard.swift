//
//  RecommendationCard.swift
//  BetterRest
//
//  Created by Muhammad Dzaky on 24/09/24.
//

import SwiftUI

struct RecommendationCard: View {
    @Binding var recommendationMessage: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 6) {
            VStack(alignment: .leading) {
                Text("Sleep Time")
                    .font(.headline.weight(.medium))
                    .foregroundStyle(.primary)
                Text("Suggested time to sleep")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(recommendationMessage)
                .foregroundStyle(.blue)
                .font(.system(size:24, weight: .semibold))
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(.elevation1)
    }
}

#Preview {
    RecommendationCard(recommendationMessage: .constant("12.00 WIB"))
}
