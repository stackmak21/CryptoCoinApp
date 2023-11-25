//
//  CircleButtonView.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 5/11/23.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            .padding()
    }
}

#Preview(traits:.sizeThatFitsLayout) {
    Group{
        CircleButtonView(iconName: "info")
        CircleButtonView(iconName: "plus")
            .preferredColorScheme(.dark)
    }
}
