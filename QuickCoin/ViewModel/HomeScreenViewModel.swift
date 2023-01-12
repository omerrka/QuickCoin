//
//  HomeScreenViewModel.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import Foundation
import Moya

protocol homeScreenDelegate {
    func updateRate()
    
}

class HomeScreenViewModel {
    
    let currencyArray = ["ADA", "BNB", "BTC", "DOGE", "ETH", "EUR", "GBP", "TRY", "USD", "XRP"]
    
    var homeScreenDelegate: homeScreenDelegate?
    
    fileprivate(set) var currencyRate: Float = Float()
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadCurrencyRate(firstCurrency: String, secondCurrency: String) {
        
        networkManager.fetchCurrencyRate(firstCurrency: firstCurrency, secondCurrency: secondCurrency, completion: { [weak self] result in
            
            guard let strongSelf = self else { return }
            switch result {
            case .success(let currency):
                strongSelf.currencyRate = currency.rate
                self?.homeScreenDelegate?.updateRate()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}


