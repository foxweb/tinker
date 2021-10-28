//
//  Position.swift
//  Tinker
//
//  Created by Aleksey Kurepin on 20.10.2021.
//

import Foundation

enum Currency: String, Decodable {
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
    case gbp = "GBP"
    case hkd = "HKD"
    case chf = "CHF"
    case jpy = "JPY"
    case cny = "CNY"
    case `try` = "TRY"
}

struct Position: Decodable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case name
        case figi
        case ticker
        case isin
        case instrumentType
        case balance
        case lots
        case expectedYield
        case averagePositionPrice
        case averagePositionPriceNoNkd
    }

    enum InstrumentType: String, Decodable {
        case stock = "Stock"
        case currency = "Currency"
        case bond = "Bond"
        case etf = "Etf"
    }

    let id = UUID()
    let name: String
    let figi: String
    let ticker: String
    let isin: String?
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

        return String(
            format: "%+g \(expectedYield.currencySymbol) (%.2f %%)",
            expectedYield.value,
            abs(percentValue)
        )
    }

    var imageURL: URL? {
        if isin != nil {
            return URL(
                string: "https://invest-brands.cdn-tinkoff.ru/\(isin!)x160.png"
            )
        }
        else {
            return nil
        }
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
