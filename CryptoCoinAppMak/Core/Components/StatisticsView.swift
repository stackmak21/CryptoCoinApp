//
//  StatisticsView.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 18/11/23.
//

import SwiftUI

struct StatisticsView: View {
    
    let stats: Statistics
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(stats.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stats.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 0.0) {
                Image(systemName: "triangle.fill")
                    .rotationEffect(Angle(degrees: stats.percentageChange ?? 0 >= 0 ? 0 : 180))
                    .font(.caption2)
                Text(stats.percentageChange?.asPercentString() ?? "")
            }
            .foregroundStyle(stats.percentageChange ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stats.percentageChange == nil ? 0.0 : 1.0)
        }
        
    }
}

#Preview() {
    Group{
        HStack(spacing: 30.0){
            StatisticsView(stats: Preview.dev.stats1)
            StatisticsView(stats: Preview.dev.stats2)
            StatisticsView(stats: Preview.dev.stats3)
        }
    }
    .preferredColorScheme(.dark)
}


