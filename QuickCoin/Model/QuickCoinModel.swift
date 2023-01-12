//
//  QuickCoinMODEL.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import Foundation

struct HomeScreenCoinData: Codable {
    let rate: Float
    
}

struct SearchScreenCoinData: Codable {
    let assetIDBase: String
    let rates: [Rate]

    enum CodingKeys: String, CodingKey {
        case assetIDBase = "asset_id_base"
        case rates
    }
}

struct Rate: Codable {
    let time, assetIDQuote: String
    let rate: Double

    enum CodingKeys: String, CodingKey {
        case time
        case assetIDQuote = "asset_id_quote"
        case rate
    }
}

struct DetailedScreenCoinData: Codable {
    let timePeriodStart, timePeriodEnd, timeOpen, timeClose: String
    let rateOpen, rateHigh, rateLow, rateClose: Float

    enum CodingKeys: String, CodingKey {
        case timePeriodStart = "time_period_start"
        case timePeriodEnd = "time_period_end"
        case timeOpen = "time_open"
        case timeClose = "time_close"
        case rateOpen = "rate_open"
        case rateHigh = "rate_high"
        case rateLow = "rate_low"
        case rateClose = "rate_close"
    }
}

