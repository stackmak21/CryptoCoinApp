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
    
    
    let coinDataService = CoinDataService()
    let marketDataService = MarketDataService()
    let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers(){
        
        
        // update all coins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coinsAfterFilter in
                self?.allCoins = coinsAfterFilter
            }
            .store(in: &cancellables)
        
        
        // update portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            })
            .store(in: &cancellables)
        
        
        
        
        // update market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
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
    
    
    
    func updatePortfolio(coin: Coin, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData(){
        marketDataService.getData()
        coinDataService.getCoins()
        portfolioDataService.getPortfolio()
    }
    
    private func mapAllCoinsToPortfolioCoins(coins: [Coin], portfolioEntities: [Portfolio]) -> [Coin]{
        coins
            .compactMap { coin -> Coin? in
                guard let entity = portfolioEntities.first(where: { $0.coinID  == coin.id })
                else { return nil }
                return coin.updateHoldingsValue(amount: entity.amount)
            }
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
    
    private func mapGlobalMarketData(marketData: MarketData?, portfolioCoins: [Coin]) -> [Statistics]{
        var stats: [Statistics] = []
        guard let data = marketData else { return stats }
        
        let marketCap = Statistics(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistics(title: "24h Volume", value: data.volume)
        let btcDominannce = Statistics(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = 
        portfolioCoins
            .map({$0.currentHoldingsValue})
            .reduce(0, +)
      
        let previousValue = 
        portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentageChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentageChange)
                return previousValue
            }
            .reduce(0, +)
        
       let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = Statistics(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
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
    
    

