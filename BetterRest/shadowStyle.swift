//
//  shadowStyle.swift
//  BetterRest
//
//  Created by Muhammad Dzaky on 24/09/24.
//

import SwiftUI

// Define a struct for multiple reusable shadow styles
struct ShadowStyle {
    
    static let elevation1 = ShadowStyle(
        color1: Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0.12), radius1: 1,
        color2: Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0.08), radius2: 6,
        color3: Color(red: 0.13, green: 0.13, blue: 0.13).opacity(0.04), radius3: 12
    )
    
    // Add more here
    
    var color1: Color
    var radius1: CGFloat
    var color2: Color
    var radius2: CGFloat
    var color3: Color
    var radius3: CGFloat
    
    // Apply the shadows to a view
    func apply(to view: some View) -> some View {
        view
            .shadow(color: color1, radius: radius1)
            .shadow(color: color2, radius: radius2)
            .shadow(color: color3, radius: radius3)
    }
}


extension View {
    // This method allows you to call `.shadow(.elevation3)`
    func shadow(_ style: ShadowStyle) -> some View {
        style.apply(to: self)
    }
}
