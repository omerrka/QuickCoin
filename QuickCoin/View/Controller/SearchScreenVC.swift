//
//  SearchScreenVC.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import UIKit

class SearchScreenVC: UIViewController {
    
    let searchBar = UISearchBar()
    let appearance = UINavigationBarAppearance()
    var usdLabel = UILabel()
    var eurLabel = UILabel()
    var audLabel = UILabel()
    var tryLabel = UILabel()
    
    var searchScreenViewModel = SearchScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        searchBar.delegate = self
        
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.tintColor = .black
        searchBar.sizeToFit()
        
        showSearchBarButton(shouldShow: true)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search Currency"
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        searchScreenViewModel.searchScreenDelegate = self
        configureLabels()
        
    }
    
    func configureLabels() {
        
        view.addSubview(usdLabel)
        usdLabel.translatesAutoresizingMaskIntoConstraints = false
        usdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usdLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72).isActive = true
        usdLabel.textAlignment = .center
        usdLabel.font = UIFont.systemFont(ofSize: 24)
        
        view.addSubview(eurLabel)
        eurLabel.translatesAutoresizingMaskIntoConstraints = false
        eurLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eurLabel.topAnchor.constraint(equalTo: usdLabel.bottomAnchor, constant: 72).isActive = true
        eurLabel.textAlignment = .center
        
        view.addSubview(audLabel)
        audLabel.translatesAutoresizingMaskIntoConstraints = false
        audLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        audLabel.topAnchor.constraint(equalTo: eurLabel.bottomAnchor, constant: 72).isActive = true
        audLabel.textAlignment = .center
        
        view.addSubview(tryLabel)
        tryLabel.translatesAutoresizingMaskIntoConstraints = false
        tryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tryLabel.topAnchor.constraint(equalTo: audLabel.bottomAnchor, constant: 72).isActive = true
        tryLabel.textAlignment = .center
        
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
    
    func updateEURCurrency(EUR: Int) {
        
        updateCurrency(currencyLabel: eurLabel, currencyValue: searchScreenViewModel.searchedCurrency[EUR].rate, currencySembol: "eurosign.circle")
        
    }
    
    func updateAUDCurrency(AUD: Int) {
        
        updateCurrency(currencyLabel: audLabel, currencyValue: searchScreenViewModel.searchedCurrency[AUD].rate, currencySembol: "australsign.circle")
        
    }
    
    func updateTRYCurrency(TRY: Int) {
        
        updateCurrency(currencyLabel: tryLabel, currencyValue: searchScreenViewModel.searchedCurrency[TRY].rate, currencySembol: "turkishlirasign.circle")
        
    }
    
    func updateUSDCurrency(USD: Int) {
        
        updateCurrency(currencyLabel: usdLabel, currencyValue: searchScreenViewModel.searchedCurrency[USD].rate, currencySembol: "dollarsign.circle")
        
    }
    
    
    func updateCurrency(currencyLabel: UILabel, currencyValue: Double, currencySembol: String) {
        
        currencyLabel.font = UIFont.systemFont(ofSize: 28)
        currencyLabel.textColor = .systemBlue
        let imageAttachment = NSTextAttachment()
        let config = UIImage.SymbolConfiguration(pointSize: 28)
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
