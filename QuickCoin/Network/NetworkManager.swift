//
//  Network.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import Moya

protocol Networkable {
    var provider: MoyaProvider<API> { get }
    
    func fetchCurrencyRate(firstCurrency: String, secondCurrency: String, completion: @escaping (Result<HomeScreenCoinData, Error>) -> ())
    func fetchSearchedCurrency(searchedCurrency: String, completion: @escaping (Result<SearchScreenCoinData, Error>) -> ())
    func fetchCurrencyDetail(firstCurrency: String, secondCurrency: String, periodID: String, limit: String, timeEnd: String, timeStart: String, completion: @escaping (Result<[DetailedScreenCoinData], Error>) -> ())
}

class NetworkManager: Networkable {
    
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    func fetchCurrencyDetail(firstCurrency: String, secondCurrency: String, periodID: String, limit: String, timeEnd: String, timeStart: String, completion: @escaping (Result<[DetailedScreenCoinData], Error>) -> ()) {
        request(target: .detailScreen(firstCurrency: firstCurrency, secondCurrency: secondCurrency, periodID: periodID, limit: limit, timeStart: timeStart, timeEnd: timeEnd), completion: completion)
    }
    
    func fetchSearchedCurrency(searchedCurrency: String, completion: @escaping (Result<SearchScreenCoinData, Error>) -> ()) {
        request(target: .searchScreen(searchedCurrency: searchedCurrency), completion: completion)
    }
    
    
    func fetchCurrencyRate(firstCurrency: String, secondCurrency: String, completion: @escaping (Result<HomeScreenCoinData, Error>) -> ()) {
        request(target: .homeScreen(firstCurrency: firstCurrency, secondCurrency: secondCurrency), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

