//
//  MarketDataService.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 07/08/23.
//

import Foundation
import Combine

class MarketDataService {
    @Published var MarketData: MarketDataModel? = nil
    var MarketDataSubscription: AnyCancellable?
//    @Published var portfolioCoins: [CoinModel] = []
    init ()
    {
        getData()
    }
<<<<<<< HEAD
    func getData() {
=======
    private func getData() {
>>>>>>> dffd75de0a984333e233edd3a4ff99ffb8e1b4af
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        MarketDataSubscription = NetworkingManager.Download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.MarketData = returnedGlobalData.data
                self?.MarketDataSubscription?.cancel()
            })
        
    }
    
}
