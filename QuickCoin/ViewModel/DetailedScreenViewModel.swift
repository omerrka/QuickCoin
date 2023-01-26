//
//  DetailedScreenViewModel.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import Foundation
import Moya

protocol DetailedScreenProtocol {
    func didUpdateTableView()
}

class DetailedScreenViewModel {
    
    let newFormatter = ISO8601DateFormatter()
    var timeStart: String = ""
    var timeEnd: String = ""
    
    fileprivate(set) var currencyRate: [DetailedScreenCoinData]? = []
    var delegate: DetailedScreenProtocol?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func dateFormatter(start: Date, end: Date) {
        
    timeStart = newFormatter.string(from: start)
    timeEnd = newFormatter.string(from: end)
        
    }
    
    func loadCurrencyDetail(firstCurrency: String, secondCurrency: String, periodID: String, limit: String, timeStart: String, timeEnd: String) {
        
        networkManager.fetchCurrencyDetail(firstCurrency: firstCurrency,
                                           secondCurrency: secondCurrency,
                                           periodID: periodID,
                                           limit: limit,
                                           timeEnd: timeEnd,
                                           timeStart: timeStart,
                                           completion: { [weak self] result in
            
            guard let strongSelf = self else { return }
            switch result {
            case .success(let detailedCurrency):
                strongSelf.currencyRate = detailedCurrency
                strongSelf.delegate?.didUpdateTableView()
                
            case .failure(let error):
                print(error)
            }
        })
    }
}


