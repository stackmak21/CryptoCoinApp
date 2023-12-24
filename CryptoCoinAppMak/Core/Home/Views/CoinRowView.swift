//
//  CoinRowView.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 5/11/23.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        
        
        
        HStack(spacing: 0.0){
                leftColumn
                    
                Spacer()
                if showHoldingsColumn{
                    centerColumn
                        
                        .animation(.none, value: showHoldingsColumn)
                }
                rightColumn
                .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
            }

            .font(.subheadline)
        
    }
}

#Preview(traits: .sizeThatFitsLayout){
    CoinRowView(coin: Preview.dev.coin, showHoldingsColumn: true )
        .frame(maxWidth: .infinity, maxHeight: 45)
    
}


extension CoinRowView{
    
    private var leftColumn: some View {
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith6Decimals())
                .bold()
            Text(coin.currentHoldings?.asNumberString() ?? "0")
        }
        .foregroundStyle(Color.theme.accent)
        .onAppear {
            print("CoinRowView \(coin.symbol.uppercased()) : \(coin.currentHoldings?.asNumberString() ?? "-")")
            }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0")
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ?
                                 Color.theme.green : Color.theme.red
                )
            
        }
    }
    
}

