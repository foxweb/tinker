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

    private(set) var id = UUID()
    let name: String
    let figi: String
    let ticker: String
    let instrumentType: InstrumentType
    let balance: Double
    let lots: Int
    let expectedYield: MoneyAmount
    let averagePositionPrice: MoneyAmount
    let averagePositionPriceNoNkd: MoneyAmount?

    // вычисления и форматирование

    // общая сумма по позиции
    var positionCost: Double {
        return (averagePositionPrice.value * balance) + expectedYield.value
    }

    // вычисление текущей цены позиции
    var currentPrice: Double {
        return ((balance * averagePositionPrice.value) + expectedYield.value) / balance
    }

    // форматированная общая сумма
    var positionCostFormatted: String {
        return String(format: "%.2f \(averagePositionPrice.currencySymbol)", positionCost)
    }

    // форматированная текущая цена
    var currentPriceFormatted: String {
        return String(format: "%.2f \(averagePositionPrice.currencySymbol)", currentPrice)
    }

    // форматированная сумма и процент профита
    var expectedYieldFormatted: String {
        let buyCost = balance * averagePositionPrice.value
        let percentValue = (expectedYield.value / buyCost) * 100

        return String(format: "%+g \(expectedYield.currencySymbol) (%.2f %%)", expectedYield.value, abs(percentValue))
    }
}

struct MoneyAmount: Decodable {
    var currencySymbol: String {
        let result = Locale
            .availableIdentifiers
            .map { Locale(identifier: $0) }
            .first { $0.currencyCode == currency.rawValue }
        
        return result?.currencySymbol == "RUB" ? "₽" : String(result?.currencySymbol ?? "?")
    }

    let currency: Currency
    let value: Double
}

struct PortfolioResponse: Decodable {
    let payload: Payload
}

struct Payload: Decodable {
    let positions: [Position]
}
