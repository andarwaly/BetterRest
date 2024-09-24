//
//  ContentView.swift
//  BetterRest
//
//  Created by Muhammad Dzaky on 23/09/24.
//

import CoreML
import SwiftUI


struct ContentView: View {
    @StateObject private var sleepModel = SleepCalVM()
    
    var body: some View {
        NavigationStack {
            VStack (alignment:.leading) {
                VStack (alignment: .leading, spacing: 20) {
                    RecommendationCard(recommendationMessage: $sleepModel.recommendationMessage)
                    VStack (alignment: .leading, spacing: 12) {
                        Text("Your input")
                            .font(.subheadline.weight(.semibold))
                        UserInputView(sleepModel: sleepModel)
                    }
                }
                .padding(.vertical,32)
                .padding(.horizontal, 16)
                .navigationTitle("Better Rest")
                Spacer()
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .onAppear {
                sleepModel.calculateBedtime()
            }
        }
    }
}




#Preview {
    ContentView()
}


