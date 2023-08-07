//
//  DetailViewModel.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 01/09/23.
//

import Foundation
import Combine


class DetailViewModel: ObservableObject {
    @Published var overviewStatistics: [StasticalModel] = []
    @Published var additionalStatistics: [StasticalModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var reddirURL: String? = nil
    
    @Published var coin: CoinModel
    private let CoinDetailService: coinDetailService
    private var cancallables = Set<AnyCancellable>()
   
    init(coin: CoinModel)
    {
        self.coin = coin
        self.CoinDetailService = coinDetailService(coin: coin)
        self.addSubscribers()
        
    }
    private func addSubscribers(){
        CoinDetailService.$CoinDetails
            .combineLatest($coin)
            .map(mapDatatoStatsics)
            .sink { (returnedArrays) in
                self.overviewStatistics = returnedArrays.overview
                self.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancallables)
        
        CoinDetailService.$CoinDetails
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.reddirURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancallables)
        
    }
    private func mapDatatoStatsics(CoinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StasticalModel], additional: [StasticalModel]){
        let price = coinModel.currentPrice.asCurrency6Decimals()
        let pricepercantagechange = coinModel.priceChangePercentage24H
        let pricestat = StasticalModel(title: "Current Price", value: price, PerecentageChange: pricepercantagechange)
        let marketcap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marCapChange = coinModel.marketCapChangePercentage24H
        let markcapstats =  StasticalModel(title: "Market Captilization", value: marketcap, PerecentageChange: marCapChange)
        let rank = "\(coinModel.Rank)"
        let rankstats = StasticalModel(title: "Rank", value: rank)
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumestat = StasticalModel(title: "Volume" , value: volume)
        let overviewArray: [StasticalModel] = [
            pricestat, markcapstats, rankstats, volumestat
        ]
        // additonal
        let high = coinModel.high24H?.asCurrency6Decimals() ?? "n/a"
        let highstat = StasticalModel(title: "24h High", value: high)
        let low = coinModel.low24H?.asCurrency6Decimals() ?? "n/a"
        let lowstat = StasticalModel(title: "24h low", value: low)
        let priceChange = coinModel.priceChange24H?.asCurrency6Decimals() ?? "n/a"
        let pricepercentageChange2 = coinModel.priceChangePercentage24H
        let pricechangeStats = StasticalModel(title: "24h Price Change", value: priceChange, PerecentageChange: pricepercentageChange2)
        let marketcapchange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketcappercentagechange = coinModel.marketCapChangePercentage24H
        let markercapChangestas = StasticalModel(title: "24h Market Cap  Change", value: marketcapchange , PerecentageChange: marketcappercentagechange)
        let blockTime = CoinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockstats = StasticalModel(title: "Block Time", value: blockTimeString)
        let hashing = CoinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingstats = StasticalModel(title: "Hashing Algorithm", value: hashing)
        let addionalArray: [StasticalModel] = [
            highstat, lowstat, pricechangeStats , markercapChangestas, blockstats, hashingstats
        ]
        
        return (overviewArray, addionalArray)
        
    }
    
}
