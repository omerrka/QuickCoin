//
//  SearchScreenViewModel.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import Foundation
import Moya

protocol SearchScreenDelegate {
    func updateUSDCurrency(USD: Int)
    func updateEURCurrency(EUR: Int)
    func updateAUDCurrency(AUD: Int)
    func updateTRYCurrency(TRY: Int)
    
}

class SearchScreenViewModel {
    
    
    fileprivate(set) var searchedCurrency: [Rate] = [Rate]()
    
    var searchScreenDelegate: SearchScreenDelegate?
    
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loadSearchedCurrency(searchedCurrency: String) {
        
        networkManager.fetchSearchedCurrency(searchedCurrency: searchedCurrency, completion: { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let searchedCurrency):
                strongSelf.searchedCurrency = searchedCurrency.rates
                if let USD = strongSelf.searchedCurrency.firstIndex(where: { $0.assetIDQuote == "USD" }) {
                    strongSelf.searchScreenDelegate?.updateUSDCurrency(USD: USD)
                }
                if let EUR = strongSelf.searchedCurrency.firstIndex(where: { $0.assetIDQuote == "EUR" }) {
                    strongSelf.searchScreenDelegate?.updateEURCurrency(EUR: EUR)
                }
                if let AUD = strongSelf.searchedCurrency.firstIndex(where: { $0.assetIDQuote == "AUD" }) {
                    strongSelf.searchScreenDelegate?.updateAUDCurrency(AUD: AUD)
                }
                if let TRY = strongSelf.searchedCurrency.firstIndex(where: { $0.assetIDQuote == "TRY" }) {
                    strongSelf.searchScreenDelegate?.updateTRYCurrency(TRY: TRY)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}


