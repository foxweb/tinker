//
//  Position.swift
//  Tinker
//
//  Created by Aleksey Kurepin on 20.10.2021.
//

import Foundation

enum Currency: String, Decodable {
    case RUB, USD, EUR, GBP, HKD, CHF, JPY, CNY, TRY
}

struct Position: Decodable, Identifiable {
    enum InstrumentType: String, Decodable {
        case Stock, Currency, Bond, Etf
    }
    
    let id = UUID()
    let name: String
    let figi: String
    let ticker: String
    let instrumentType: InstrumentType
    let balance: Double
    let lots: Int
    let expectedYield: ExpectedYield
    let averagePositionPrice: AveragePositionPrice
}

struct ExpectedYield: Decodable {
    let currency: Currency
    let value: Double
}

struct AveragePositionPrice: Decodable {
    let currency: Currency
    let value: Double
}

struct PortfolioResponse: Decodable {
    let payload: Payload
}

struct Payload: Decodable {
    let positions: [Position]
}
