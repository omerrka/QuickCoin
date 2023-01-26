//
//  HomeScreenVC.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import UIKit

class HomeScreenVC: UIViewController {
    
    
    let constants = Constants()
    let homeScreenViewModel = HomeScreenViewModel()
    var firstPicker = UIPickerView()
    var secondPicker = UIPickerView()
    var firstTextField = UITextField()
    var secondTextField = UITextField()
    var thirdTextField = UITextField()
    var mainTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = constants.homeScreenTitle
        navigationController?.navigationBar.prefersLargeTitles = true

        pickerConfiguration()
        
        homeScreenViewModel.homeScreenDelegate = self
        
        configureTextField()
        
    }
    
    func configureTextField() {
        view.addSubview(firstTextField)
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        firstTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90).isActive = true
        firstTextField.textAlignment = .center
        firstTextField.placeholder = "Select First Currency"
        firstTextField.font = UIFont.systemFont(ofSize: 30)
        firstTextField.textColor = .systemBlue
        
        view.addSubview(secondTextField)
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        secondTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 72).isActive = true
        secondTextField.textAlignment = .center
        secondTextField.placeholder = "Select Second Currency"
        secondTextField.font = UIFont.systemFont(ofSize: 30)
        secondTextField.textColor = .systemBlue
        
        view.addSubview(thirdTextField)
        thirdTextField.translatesAutoresizingMaskIntoConstraints = false
        thirdTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thirdTextField.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 72).isActive = true
        thirdTextField.textAlignment = .center
        thirdTextField.placeholder = "Result"
        thirdTextField.font = UIFont.systemFont(ofSize: 30)
        thirdTextField.textColor = .systemBlue
        
    }
    
    func pickerConfiguration() {
        
        firstPicker.delegate = self
        firstPicker.dataSource = self
        
        secondPicker.delegate = self
        secondPicker.dataSource = self
        
        firstTextField.inputView = firstPicker
        secondTextField.inputView = secondPicker
        
        firstPicker.tag = 1
        secondPicker.tag = 2
        
    }
}

extension HomeScreenVC: UIPickerViewDelegate, UIPickerViewDataSource, homeScreenDelegate {
    func updateRate() {
        thirdTextField.text = "1 \(firstTextField.text!) = " + String(homeScreenViewModel.currencyRate) + " \(secondTextField.text!)"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return homeScreenViewModel.currencyArray.count
        case 2:
            return homeScreenViewModel.currencyArray.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return homeScreenViewModel.currencyArray[row]
        case 2:
            return homeScreenViewModel.currencyArray[row]
        default:
            return homeScreenViewModel.currencyArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            homeScreenViewModel.firstCurrency = homeScreenViewModel.currencyArray[row]
            firstTextField.text = homeScreenViewModel.currencyArray[row]
            firstTextField.resignFirstResponder()
        case 2:
            homeScreenViewModel.secondCurrency = homeScreenViewModel.currencyArray[row]
            secondTextField.text = homeScreenViewModel.currencyArray[row]
            secondTextField.resignFirstResponder()
        default:
            return
        }
        
        if homeScreenViewModel.secondCurrency != "" {
            homeScreenViewModel.loadCurrencyRate(firstCurrency: homeScreenViewModel.firstCurrency,
                                                 secondCurrency: homeScreenViewModel.secondCurrency)
            
        }
    }
}

