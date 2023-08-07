//
//  HomeViewModel.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 03/08/23.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistical: [StasticalModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    private var CoindataSerivce = coinDataService()
    private var MarketDataSerive = MarketDataService()
    private var portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption{
        case rank,rankReversed,holdings,holdingsReversed,price,priceReversed
    }
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
            .combineLatest(CoindataSerivce.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterandsortCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        //updates Portfolio Coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else{ return }
                
                self.portfolioCoins = self.sortPortfolioCoinsIfneeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        //update market data
        MarketDataSerive.$MarketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            
            .sink { [weak self] (returnedStas) in
                self?.statistical = returnedStas
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
    }
    func updatePortfolio(coin: CoinModel,amount: Double)
    {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    func reloadData()
    {
        isLoading = true;
        CoindataSerivce.getCoins()
        MarketDataSerive.getData()
        HapticManager.notifications(type: .success)
    }
    private func filterandsortCoins(text: String,coins: [CoinModel],sort: SortOption) -> [CoinModel]{
        var updatedcoins = filteredCoins(text: text, coins: coins)
        // sort
        sortCoins(sort: sort, coins: &updatedcoins)
        return updatedcoins
        
    }
    private func sortCoins(sort: SortOption, coins: inout [CoinModel] )
    {
        switch sort {
        case .rank, .holdings :
                 coins.sort(by: {$0.Rank < $1.Rank})
        case .rankReversed, .holdingsReversed :
                 coins.sort(by: {$0.Rank > $1.Rank})
            case .price :
                 coins.sort(by: {$0.currentPrice < $1.currentPrice})
            case .priceReversed :
                 coins.sort(by: {$0.currentPrice > $1.currentPrice})
            
        
        }
    }
    private func sortPortfolioCoinsIfneeded(coins: [CoinModel]) -> [CoinModel]
    {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default :
            return coins
        }
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
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioCoins: [PortfolioEntity] ) -> [CoinModel]
    {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioCoins.first(where: { $0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
        
    }
    
    private func mapGlobalMarketData(MarketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StasticalModel]
    {
        var stats: [StasticalModel] = []
        guard let data = MarketDataModel else { return stats }
        
        let marketCap = StasticalModel(title: "Maket Cap", value: data.marketCap, PerecentageChange: data.marketCapChangePercentage24HUsd)
        stats.append(marketCap)
        let volume = StasticalModel(title: "24 Volume", value: data.volume)
        stats.append(volume)
        let BitcoinDominance = StasticalModel(title: "Btc Dominance", value: data.BtcDominance)
        let portFolioValue =
            portfolioCoins
                .map { $0.currentHoldingsValue }
                .reduce(0, +)
        let previousValue =
            portfolioCoins
            .map { (coin) -> Double in
                let cuurentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previosValue = cuurentValue / (1 + percentChange)
                return previosValue
            }
            .reduce(0, + )
        let percentChange = ((portFolioValue-previousValue)/previousValue)*100
        let portfolio = StasticalModel(title: "Portfolio", value: portFolioValue.asCurrency2Decimals(), PerecentageChange: percentChange)
        stats.append(contentsOf: [
            marketCap,
            volume,
            BitcoinDominance,
            portfolio
        ])
        return stats
    }
}


 
