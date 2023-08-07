//
//  MarketDataModel.swift
//  SwiftCrypto
//
//  Created by Harsha Vardhan Ravipati on 07/08/23.
//

import Foundation
import Combine

// JSON Data
/*
 curl -X 'GET' \
   URL: 'https://api.coingecko.com/api/v3/global'

 JSON:
 {
   "data": {
     "active_cryptocurrencies": 10023,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 795,
     "total_market_cap": {
       "btc": 41578000.040969536,
       "eth": 658608996.5522403,
       "ltc": 14608518214.413307,
       "bch": 5236789646.825468,
       "bnb": 4963261175.916656,
       "eos": 1652983722335.6506,
       "xrp": 1946961339897.0645,
       "xlm": 8711574173652.968,
       "link": 168847833656.729,
       "dot": 241794534859.16953,
       "yfi": 187102678.02289215,
       "usd": 1208411991256.9575,
       "aed": 4438539538306.499,
       "ars": 337527837020335.56,
       "aud": 1838134814492.8198,
       "bdt": 130931358289088.02,
       "bhd": 455570112291.88184,
       "bmd": 1208411991256.9575,
       "brl": 5899328373937.491,
       "cad": 1616502388000.3645,
       "chf": 1058579780049.0182,
       "clp": 1026002201176722,
       "cny": 8691865770713.044,
       "czk": 26714303470117.992,
       "dkk": 8201203374195.078,
       "eur": 1100644601464.6719,
       "gbp": 949915748559.2178,
       "hkd": 9433649471546.139,
       "huf": 429998191973406.4,
       "idr": 18343703538691404,
       "ils": 4423682112874.003,
       "inr": 99979775089395.36,
       "jpy": 171877976067409.22,
       "krw": 1576667525362132,
       "kwd": 371879123013.39886,
       "lkr": 385615851455855.44,
       "mmk": 2522564484747086,
       "mxn": 20632469841552.996,
       "myr": 5506733444157.965,
       "ngn": 925595248823180.8,
       "nok": 12261868857599.54,
       "nzd": 1981653073046.4446,
       "php": 67552039304014.94,
       "pkr": 340414334491491.44,
       "pln": 4881693217388.22,
       "rub": 115723573134310.75,
       "sar": 4533442174039.866,
       "sek": 12826028079837.76,
       "sgd": 1620697994434.0078,
       "thb": 42088786642265.43,
       "try": 32630747791499.652,
       "twd": 38306658914433.586,
       "uah": 44366575574713.22,
       "vef": 120998292684.55936,
       "vnd": 28645540927845812,
       "zar": 22329471802762.92,
       "xdr": 894518517644.0256,
       "xag": 51447838424.767105,
       "xau": 623673512.8076278,
       "bits": 41578000040969.54,
       "sats": 4157800004096953.5
     },
     "total_volume": {
       "btc": 916545.141385682,
       "eth": 14518372.102266686,
       "ltc": 322030073.09325445,
       "bch": 115439754.25771348,
       "bnb": 109410094.56280044,
       "eos": 36438361585.53796,
       "xrp": 42918802125.88505,
       "xlm": 192037880004.20685,
       "link": 3722080461.2795444,
       "dot": 5330117031.132097,
       "yfi": 4124490.122496344,
       "usd": 26638225462.68233,
       "aed": 97843134462.3234,
       "ars": 7440461272754.213,
       "aud": 40519830962.89353,
       "bdt": 2886249944120.5264,
       "bhd": 10042584361.205778,
       "bmd": 26638225462.68233,
       "brl": 130044753312.88736,
       "cad": 35634167307.23391,
       "chf": 23335325249.338932,
       "clp": 22617185329090.48,
       "cny": 191603428107.98148,
       "czk": 588889918392.2451,
       "dkk": 180787269679.3398,
       "eur": 24262601877.69488,
       "gbp": 20939936101.058125,
       "hkd": 207955302808.24927,
       "huf": 9478877128998.707,
       "idr": 404368472192990.56,
       "ils": 97515617480.2599,
       "inr": 2203953461078.542,
       "jpy": 3788876899335.2236,
       "krw": 34756047874532.434,
       "kwd": 8197700780.336791,
       "lkr": 8500513125809.445,
       "mmk": 55607393815210.19,
       "mxn": 454822020525.95514,
       "myr": 121390393433.44359,
       "ngn": 20403815175396.195,
       "nok": 270300551124.80576,
       "nzd": 43683546448.19448,
       "php": 1489116680787.4622,
       "pkr": 7504091202770.16,
       "pln": 107612011056.9002,
       "rub": 2551009634795.5527,
       "sar": 99935167499.03519,
       "sek": 282736873064.31354,
       "sgd": 35726655226.04032,
       "thb": 927804917643.3508,
       "try": 719311975530.5859,
       "twd": 844431720528.8049,
       "uah": 978016480899.8795,
       "vef": 2667285515.5783863,
       "vnd": 631462103369836.8,
       "zar": 492230719860.61084,
       "xdr": 19718759931.172394,
       "xag": 1134115789.5173335,
       "xau": 13748254.543544965,
       "bits": 916545141385.682,
       "sats": 91654514138568.2
     },
     "market_cap_percentage": {
       "btc": 46.78032849303554,
       "eth": 18.24363455726173,
       "usdt": 6.931439960820773,
       "bnb": 3.1005280664274566,
       "xrp": 2.71053080999543,
       "usdc": 2.1544409095435313,
       "steth": 1.2120179257072838,
       "doge": 0.8683526678184386,
       "ada": 0.847918236177664,
       "sol": 0.7783064649032306
     },
     "market_cap_change_percentage_24h_usd": 0.02931418978866688,
     "updated_at": 1691389537
   }
 }
 
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
        
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        
        
    }
    var marketCap: String {
       
        if let item = totalMarketCap.first(where: {$0.key == "usd" })
        {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
            
    }
    var volume: String {
       
        if let item = totalVolume.first(where: {$0.key == "usd" })
        {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
            
    }
    
    var BtcDominance: String{
        if let item = marketCapPercentage.first(where: {$0.key == "btc" })
        {
            return item.value.aspercentageString()
        }
        return ""
    }
}
