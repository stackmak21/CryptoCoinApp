//
//  HomeStatsView.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 18/11/23.
//

import SwiftUI

struct HomeStatsView: View {
    
    @Binding var showPortfolio: Bool
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(vm.statistics){ stats in
                    StatisticsView(stats: stats)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
        
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(true))
        .environmentObject(Preview.dev.homeVm)
}
