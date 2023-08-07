//
//  HomeViewModel.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 03/08/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistical: [StasticalModel] = [StasticalModel(title: "Title", value: "Value", PerecentageChange: 1),
                                         StasticalModel(title: "Title", value: "Value"),
                                         StasticalModel(title: "Title", value: "Value"),
                                         StasticalModel(title: "Title", value: "Value", PerecentageChange: -7),]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    private var CoindataSerivce = coinDataService()
    private var MarketDataSerive = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    init () {
        addSubscribers()
    }
    func addSubscribers() {
        // updates all coins
        CoindataSerivce.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        $searchText
            .combineLatest(CoindataSerivce.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filteredCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        //update market data
        MarketDataSerive.$MarketData
            .map(mapGlobalMarketData)
            
            .sink { [weak self] (returnedStas) in
                self?.statistical = returnedStas
            }
            .store(in: &cancellables)
        
        
        
        
        
    }
    private func filteredCoins(text: String,coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else{
            return coins
        }
        let lowerCaseText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowerCaseText) ||
            coin.symbol.lowercased().contains(lowerCaseText) ||
            coin.id.lowercased().contains(lowerCaseText)
        }
        
    }
    
    private func mapGlobalMarketData(MarketDataModel: MarketDataModel?) -> [StasticalModel]
    {
        var stats: [StasticalModel] = []
        guard let data = MarketDataModel else { return stats }
        
        let marketCap = StasticalModel(title: "Maket Cap", value: data.marketCap, PerecentageChange: data.marketCapChangePercentage24HUsd)
        stats.append(marketCap)
        let volume = StasticalModel(title: "24 Volume", value: data.volume)
        stats.append(volume)
        let BitcoinDominance = StasticalModel(title: "Btc Dominance", value: data.BtcDominance)
        let portfolio = StasticalModel(title: "Portfolio", value: "$0.00", PerecentageChange: 0)
        stats.append(contentsOf: [
            marketCap,
            volume,
            BitcoinDominance,
            portfolio
        ])
        return stats
    }
}


