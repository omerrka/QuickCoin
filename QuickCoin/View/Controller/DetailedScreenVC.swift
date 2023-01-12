//
//  DetailedScreenVC.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import UIKit

class DetailedScreenVC: UIViewController {
    
    private let detailedScreenViewModel = DetailedScreenViewModel()
    private let currencyDetailCell = CurrencyDetailCell()
    let appearance = UINavigationBarAppearance()
    var firstDateTextField = UITextField()
    var secondDateTextField = UITextField()
    var firstCurrencyTextField = UITextField()
    var secondCurrencyTextField = UITextField()
    var showDetailButton = UIButton()
    var firstDatePicker = UIDatePicker()
    var secondDatePicker = UIDatePicker()
    var tableView = UITableView()
    
    struct Cells {
        static let detailCell = "CurrencyDetailCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        showDetailButton.addTarget(self, action: #selector(showDetailAction(sender:)), for: .touchUpInside)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Detailed Currency"
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        
        detailedScreenViewModel.delegate = self
        
        createDatepicker(datePicker: firstDatePicker, dateTextField: firstDateTextField)
        createDatepicker(datePicker: secondDatePicker, dateTextField: secondDateTextField)
        textFieldConfiguration()
        configureTableView()
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 170
        tableView.register(CurrencyDetailCell.self, forCellReuseIdentifier: Cells.detailCell)
        tableView.pin(to: view, top: showDetailButton)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        return toolbar
    }
    
    func createDatepicker(datePicker: UIDatePicker, dateTextField:UITextField) {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = createToolbar()
        
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.firstDateTextField.text = dateFormatter.string(from: firstDatePicker.date)
        self.secondDateTextField.text = dateFormatter.string(from: secondDatePicker.date)
        self.view.endEditing(true)
    }
    
    
    func textFieldConfiguration() {
        
        view.addSubview(firstDateTextField)
        firstDateTextField.translatesAutoresizingMaskIntoConstraints = false
        firstDateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        firstDateTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 42).isActive = true
        firstDateTextField.widthAnchor.constraint(equalToConstant: (view.bounds.size.width)/2).isActive = true
        firstDateTextField.textAlignment = .center
        firstDateTextField.placeholder = "First Date"
        firstDateTextField.font = UIFont.systemFont(ofSize: 22)
        firstDateTextField.textColor = .systemBlue
        
        view.addSubview(secondDateTextField)
        secondDateTextField.translatesAutoresizingMaskIntoConstraints = false
        secondDateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        secondDateTextField.topAnchor.constraint(equalTo: firstDateTextField.bottomAnchor, constant: 24).isActive = true
        secondDateTextField.widthAnchor.constraint(equalToConstant: (view.bounds.size.width)/2).isActive = true
        secondDateTextField.textAlignment = .center
        secondDateTextField.placeholder = "Second Date"
        secondDateTextField.font = UIFont.systemFont(ofSize: 22)
        secondDateTextField.textColor = .systemBlue
        
        view.addSubview(firstCurrencyTextField)
        firstCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        firstCurrencyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        firstCurrencyTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 42).isActive = true
        firstCurrencyTextField.textAlignment = .center
        firstCurrencyTextField.widthAnchor.constraint(equalToConstant: (view.bounds.size.width)/2).isActive = true
        firstCurrencyTextField.placeholder = "First Currency"
        firstCurrencyTextField.font = UIFont.systemFont(ofSize: 22)
        firstCurrencyTextField.textColor = .systemBlue
        
        view.addSubview(secondCurrencyTextField)
        secondCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        secondCurrencyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        secondCurrencyTextField.topAnchor.constraint(equalTo: firstCurrencyTextField.bottomAnchor, constant: 24).isActive = true
        secondCurrencyTextField.widthAnchor.constraint(equalToConstant: (view.bounds.size.width)/2).isActive = true
        secondCurrencyTextField.textAlignment = .center
        secondCurrencyTextField.placeholder = "Second Currency"
        secondCurrencyTextField.font = UIFont.systemFont(ofSize: 22)
        secondCurrencyTextField.textColor = .systemBlue
        
        view.addSubview(showDetailButton)
        showDetailButton.translatesAutoresizingMaskIntoConstraints = false
        showDetailButton.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        showDetailButton.widthAnchor.constraint(equalToConstant: 210).isActive = true
        showDetailButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        showDetailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showDetailButton.topAnchor.constraint(equalTo: secondCurrencyTextField.bottomAnchor, constant: 20).isActive = true
        showDetailButton.setTitle("Show Currency Details", for: .normal)
        showDetailButton.setTitleColor(.black, for: .normal)
        showDetailButton.layer.cornerRadius = 25
        
    }
    
    @objc func showDetailAction(sender: UIButton) {
        
        let newFormatter = ISO8601DateFormatter()
        let timeStart = newFormatter.string(from: firstDatePicker.date)
        let timeEnd = newFormatter.string(from: secondDatePicker.date)
        
        
        detailedScreenViewModel.loadCurrencyDetail(firstCurrency: (firstCurrencyTextField.text?.uppercased())!, secondCurrency: (secondCurrencyTextField.text?.uppercased())!, periodID: "1DAY", limit: "1000", timeStart: timeStart, timeEnd: timeEnd)
        
    }
}

extension DetailedScreenVC: UITableViewDelegate, UITableViewDataSource, DetailedScreenProtocol {
    func didUpdateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (detailedScreenViewModel.currencyRate?.count) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.detailCell) as! CurrencyDetailCell
        cell.setupDetails(detail: detailedScreenViewModel.currencyRate![indexPath.row])
        cell.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 4
        return cell
    }
}
