//
//  ContentView.swift
//  BetterRest
//
//  Created by Muhammad Dzaky on 23/09/24.
//

import CoreML
import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var sleepModel = SleepCalVM()
    
    var body: some View {
        NavigationStack {
            VStack (alignment:.leading) {
                VStack (alignment: .leading, spacing: 20) {
                    RecommendationCard(recommendationMessage: $sleepModel.recommendationMessage)
                    UserInputView(sleepModel: sleepModel)
                }
                .padding(.vertical,32)
                .padding(.horizontal, 16)
                .navigationTitle("Better Rest")
                Spacer()
            }
            .onAppear {
                sleepModel.calculateBedtime()
            }
        }
    }
}




#Preview {
    ContentView()
}


