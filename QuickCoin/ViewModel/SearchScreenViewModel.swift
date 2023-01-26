//
//  SearchScreenViewModel.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import Foundation
import Moya

protocol SearchScreenDelegate {
    func updateCurrency()
}

class SearchScreenViewModel {
    
    var USDIndexNumber = Int()
    var EURIndexNumber = Int()
    var AUDIndexNumber = Int()
    var TRYIndexNumber = Int()
    
    var currencyRateDictionary = [Int: Double]()
    
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
                self?.currencyRateDictionary.removeAll()
                strongSelf.searchedCurrency = searchedCurrency.rates
                if let USDIndex = strongSelf.searchedCurrency.firstIndex(where: { $0.assetIDQuote == "USD" }) {
                    self?.currencyRateDictionary[USDIndex] = searchedCurrency.rates[USDIndex].rate
                    self?.USDIndexNumber = USDIndex
                }
                if let EURIndex = strongSelf.searchedCurrency.firstIndex(where: { $0.assetIDQuote == "EUR" }) {
                    self?.currencyRateDictionary[EURIndex] = searchedCurrency.rates[EURIndex].rate
                    self?.EURIndexNumber = EURIndex
                }
                if let AUDIndex = strongSelf.searchedCurrency.firstIndex(where: { $0.assetIDQuote == "AUD" }) {
                    self?.currencyRateDictionary[AUDIndex] = searchedCurrency.rates[AUDIndex].rate
                    self?.AUDIndexNumber = AUDIndex
                }
                if let TRYIndex = strongSelf.searchedCurrency.firstIndex(where: { $0.assetIDQuote == "TRY" }) {
                    self?.currencyRateDictionary[TRYIndex] = searchedCurrency.rates[TRYIndex].rate
                    self?.TRYIndexNumber = TRYIndex
                }
                strongSelf.searchScreenDelegate?.updateCurrency()

            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}


