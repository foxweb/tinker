//
//  TinkoffClient.swift
//  Tinker
//
//  Created by Aleksey Kurepin on 20.10.2021.
//

import Foundation

enum ApiError: Error {
    case noData
}

class TinkoffClient: ObservableObject {
    @Published var positions = [Position]()
    @Published var apiKey: String {
        didSet {
            UserDefaults.standard.set(apiKey, forKey: "ApiKey")
        }
    }

    init() {
        apiKey = UserDefaults.standard.object(forKey: "ApiKey") as? String ?? API.token
    }

    func getPortfolio(onResult: @escaping (Result<[Position], Error>) -> Void) {

        let session = URLSession.shared

        let url = API.baseURL.appendingPathComponent("/portfolio")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in

            guard let data = data else {
                DispatchQueue.main.async {
                    onResult(.failure(ApiError.noData))
                }
                return
            }

            do {
                let portfolioResponse = try JSONDecoder().decode(PortfolioResponse.self, from: data)
                DispatchQueue.main.async {
                    onResult(.success(portfolioResponse.payload.positions))
                }
            } catch(let error) {
                print(error)
                DispatchQueue.main.async {
                    onResult(.failure(error))
                }
            }
        })

        dataTask.resume()
    }
}
