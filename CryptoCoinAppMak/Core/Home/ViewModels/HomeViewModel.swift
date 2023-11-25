//
//  HomeViewModel.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 10/11/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [Statistics] = []
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers(){
        
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
            }
            .store(in: &cancellables)
        
        
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coinsAfterFilter in
                self?.allCoins = coinsAfterFilter
            }
            .store(in: &cancellables)
        
        //        We dont need this because we subscribed to this publisher below
        //        dataService.$allCoins
        //            .sink { [weak self] returnedCoins in
        //                self?.allCoins = returnedCoins
        //            }
        //            .store(in: &cancellables)
        // filter coins
    }
    
    
    
    
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin]{
        guard !text.isEmpty else { return coins }
        let lowercasedText = text.lowercased()
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapGlobalMarketData(marketData: MarketData?) -> [Statistics]{
        var stats: [Statistics] = []
        guard let data = marketData else { return stats }
        
        let marketCap = Statistics(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistics(title: "24h Volume", value: data.volume)
        let btcDominannce = Statistics(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = Statistics(title: "Portfolio Value", value: "0.00€", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominannce,
            portfolio
        ]
        )
        
        return stats
    }
    }
    
    

