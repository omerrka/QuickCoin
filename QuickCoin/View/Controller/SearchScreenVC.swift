//
//  SearchScreenVC.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import UIKit

class SearchScreenVC: UIViewController {
    
    let constants = Constants()
    var searchScreenViewModel = SearchScreenViewModel()
    let searchBar = UISearchBar()
    var usdLabel = UILabel()
    var eurLabel = UILabel()
    var audLabel = UILabel()
    var tryLabel = UILabel()
    let config = UIImage.SymbolConfiguration(pointSize: 28)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        navigationItem.title = constants.searchScreenTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        
        searchScreenViewModel.searchScreenDelegate = self
        configureSearchBar()
        configureLabels()
        
    }
    
    func configureSearchBar() {
        
        searchBar.delegate = self
        
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.tintColor = .black
        searchBar.sizeToFit()
        
        showSearchBarButton(shouldShow: true)
        
    }
    
    func configureLabels() {
        
        view.addSubview(usdLabel)
        usdLabel.translatesAutoresizingMaskIntoConstraints = false
        usdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usdLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72).isActive = true
        usdLabel.textAlignment = .center
        usdLabel.font = UIFont.systemFont(ofSize: 24)
        usdLabel.textColor = .systemBlue
        
        view.addSubview(eurLabel)
        eurLabel.translatesAutoresizingMaskIntoConstraints = false
        eurLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eurLabel.topAnchor.constraint(equalTo: usdLabel.bottomAnchor, constant: 72).isActive = true
        eurLabel.textAlignment = .center
        eurLabel.font = UIFont.systemFont(ofSize: 24)
        eurLabel.textColor = .systemBlue


        view.addSubview(audLabel)
        audLabel.translatesAutoresizingMaskIntoConstraints = false
        audLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        audLabel.topAnchor.constraint(equalTo: eurLabel.bottomAnchor, constant: 72).isActive = true
        audLabel.textAlignment = .center
        audLabel.font = UIFont.systemFont(ofSize: 24)
        audLabel.textColor = .systemBlue


        view.addSubview(tryLabel)
        tryLabel.translatesAutoresizingMaskIntoConstraints = false
        tryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tryLabel.topAnchor.constraint(equalTo: audLabel.bottomAnchor, constant: 72).isActive = true
        tryLabel.textAlignment = .center
        tryLabel.font = UIFont.systemFont(ofSize: 24)
        tryLabel.textColor = .systemBlue


    }
    
    @objc func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
        
    }
}

extension SearchScreenVC: UISearchBarDelegate, SearchScreenDelegate {
    func updateCurrency() {
        
        updateCurrencyLabel(currencyLabel: usdLabel,
                           currencyValue: searchScreenViewModel.currencyRateDictionary[searchScreenViewModel.USDIndexNumber]!,
                           currencySembol: "dollarsign.circle")
            
        updateCurrencyLabel(currencyLabel: eurLabel,
                       currencyValue: searchScreenViewModel.currencyRateDictionary[searchScreenViewModel.EURIndexNumber]!,
                       currencySembol: "eurosign.circle")
            
        updateCurrencyLabel(currencyLabel: audLabel,
                           currencyValue: searchScreenViewModel.currencyRateDictionary[searchScreenViewModel.AUDIndexNumber]!,
                           currencySembol: "australsign.circle")
            
        updateCurrencyLabel(currencyLabel: tryLabel,
                           currencyValue: searchScreenViewModel.currencyRateDictionary[searchScreenViewModel.TRYIndexNumber]!,
                           currencySembol: "turkishlirasign.circle")
            
    }
        func updateCurrencyLabel(currencyLabel: UILabel, currencyValue: Double, currencySembol: String) {
            
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: currencySembol, withConfiguration: config)?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            let fullString = NSMutableAttributedString(string: "1 \(searchBar.text!.uppercased()) = " + String(format: "%.2f", currencyValue))
            fullString.append(NSAttributedString(attachment: imageAttachment))
            currencyLabel.attributedText = fullString
            
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            
            search(shouldShow: false)
            
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            searchScreenViewModel.loadSearchedCurrency(searchedCurrency: (searchBar.text?.uppercased())!)
            
        }
    }

