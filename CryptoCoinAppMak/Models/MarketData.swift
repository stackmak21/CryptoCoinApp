//
//  MarketData.swift
//  CryptoCoinAppMak
//
//  Created by Paris Makris on 18/11/23.
//

import Foundation

// JSON data:
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 Json Response:
 
 {
 "data": {
 "active_cryptocurrencies": 11004,
 "upcoming_icos": 0,
 "ongoing_icos": 49,
 "ended_icos": 3376,
 "markets": 931,
 "total_market_cap": {
 "btc": 39396932.35896599,
 "eth": 734322964.4145011,
 "ltc": 20623737860.740875,
 "bch": 6332353844.243451,
 "bnb": 5894190091.126998,
 "eos": 2031525415503.2092,
 "xrp": 2352562454283.456,
 "xlm": 12101790716322.857,
 "link": 105253683659.90352,
 "dot": 274289581980.9627,
 "yfi": 147197331.05183455,
 "usd": 1443356171246.894,
 "aed": 5301346182057.847,
 "ars": 510912000717118.06,
 "aud": 2216116075126.941,
 "bdt": 159067244876726.3,
 "bhd": 544035581491.06537,
 "bmd": 1443356171246.894,
 "brl": 7080961040520.149,
 "cad": 1980789841610.6753,
 "chf": 1278477265736.8484,
 "clp": 1282320923220880.2,
 "cny": 10407608344009.994,
 "czk": 32379747171092.91,
 "dkk": 9861875375661.52,
 "eur": 1322099819300.445,
 "gbp": 1158671486742.4995,
 "hkd": 11254208906254.871,
 "huf": 501393066767747.7,
 "idr": 22262758592163500,
 "ils": 5364839420031.011,
 "inr": 120219665706522.05,
 "jpy": 215832265067404.3,
 "krw": 1871138073281049.5,
 "kwd": 444963613896.6764,
 "lkr": 471147783569817.3,
 "mmk": 3016238166912988.5,
 "mxn": 24867006131944.25,
 "myr": 6754906881435.483,
 "ngn": 1188312482898925,
 "nok": 15595896437174.06,
 "nzd": 2407199111925.9775,
 "php": 79958327826718.39,
 "pkr": 411504917573604.9,
 "pln": 5799464273673.031,
 "rub": 129915047061118.12,
 "sar": 5413321753823.212,
 "sek": 15290871977504.488,
 "sgd": 1940159365390.075,
 "thb": 50270335993356.77,
 "try": 41394877648892.43,
 "twd": 45826125430237.375,
 "uah": 51877681962712.22,
 "vef": 144523253426.95157,
 "vnd": 35020179602456076,
 "zar": 26475727619730.93,
 "xdr": 1090087531553.3632,
 "xag": 60834373835.85028,
 "xau": 728678363.0539968,
 "bits": 39396932358965.99,
 "sats": 3939693235896599.5
 },
 "total_volume": {
 "btc": 1543501.9549521368,
 "eth": 28769471.714517485,
 "ltc": 808001481.3445089,
 "bch": 248090395.69331008,
 "bnb": 230923916.7562642,
 "eos": 79591563672.86394,
 "xrp": 92169225620.10397,
 "xlm": 474126702527.7651,
 "link": 4123652700.0306463,
 "dot": 10746179477.963089,
 "yfi": 5766930.434382849,
 "usd": 56548135568.34717,
 "aed": 207697343573.049,
 "ars": 20016626287805.64,
 "aud": 86823498418.42017,
 "bdt": 6231972611446.27,
 "bhd": 21314349450.963726,
 "bmd": 56548135568.34717,
 "brl": 277419498284.7548,
 "cad": 77603833847.22124,
 "chf": 50088472397.96819,
 "clp": 50239060082986.75,
 "cny": 407751641142.6815,
 "czk": 1268581081492.8523,
 "dkk": 386370791084.2885,
 "eur": 51797526699.25041,
 "gbp": 45394694405.117516,
 "hkd": 440919950060.29596,
 "huf": 19643691333732.5,
 "idr": 872215407446858.4,
 "ils": 210184896056.70114,
 "inr": 4709993340369.288,
 "jpy": 8455925452212.793,
 "krw": 73307871988093.94,
 "kwd": 17432885425.55229,
 "lkr": 18458734766080.8,
 "mmk": 118170863274635.84,
 "mxn": 974245208452.8264,
 "myr": 264645274459.86548,
 "ngn": 46555976077947.04,
 "nok": 611019569256.6615,
 "nzd": 94309792990.04262,
 "php": 3132625509791.921,
 "pkr": 16122033029374.355,
 "pln": 227212727187.1768,
 "rub": 5089841190919.506,
 "sar": 212084347930.44263,
 "sek": 599069251767.004,
 "sgd": 76012003830.97226,
 "thb": 1969502629668.2817,
 "try": 1621777908845.9697,
 "twd": 1795386339854.3464,
 "uah": 2032475594755.4978,
 "vef": 5662164814.458604,
 "vnd": 1372028542391430.8,
 "zar": 1037272063913.2402,
 "xdr": 42707696647.31646,
 "xag": 2383382901.195723,
 "xau": 28548326.241680156,
 "bits": 1543501954952.137,
 "sats": 154350195495213.7
 },
 "market_cap_percentage": {
 "btc": 49.61314781346836,
 "eth": 16.371119772175348,
 "usdt": 6.083328563140715,
 "bnb": 2.610329534972907,
 "xrp": 2.2834733506964233,
 "sol": 1.7266725885921657,
 "usdc": 1.6936186116172554,
 "steth": 1.217443589167595,
 "ada": 0.903577664591606,
 "doge": 0.7986647263352773
 },
 "market_cap_change_percentage_24h_usd": 1.0462909389018575,
 "updated_at": 1700339192
 }
 }
 
 */


struct GlobalData: Codable {
    let data: MarketData?
}

struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        
    }
    
    var marketCap: String {
        //      FIRST WAY
        if let item = totalMarketCap.first(where: { $0.key == "eur" }){
            return item.value.formattedWithAbbreviations() + " €"
        }
        return ""
    }
    //        SECOND WAY
    //        if let item = totalMarketCap.first(where: { (key, value) -> Bool in return key == "eur" } ){
    //            return "\(item.value)"
    //        }
    //        return ""
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "eur" }){
            return item.value.formattedWithAbbreviations() + " €"
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }){
            return item.value.asPercentString()
        }
        return ""
    }
}
