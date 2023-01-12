//
//  CurrencyDetailCell.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 11.01.2023.
//

import UIKit

class CurrencyDetailCell: UITableViewCell {
    
    var timeStartLabel = UILabel()
    var rateHighLabel = UILabel()
    var rateLowLabel = UILabel()
    var rateOpenLabel = UILabel()
    var rateCloseLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setLabelConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(timeStartLabel)
        addSubview(rateHighLabel)
        addSubview(rateLowLabel)
        addSubview(rateOpenLabel)
        addSubview(rateCloseLabel)
    }
    
    func setLabelConstraints() {
        timeStartLabel.translatesAutoresizingMaskIntoConstraints = false
        timeStartLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        timeStartLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        
        rateHighLabel.translatesAutoresizingMaskIntoConstraints = false
        rateHighLabel.topAnchor.constraint(equalTo: timeStartLabel.bottomAnchor, constant: 12).isActive = true
        rateHighLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        
        rateLowLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLowLabel.topAnchor.constraint(equalTo: rateHighLabel.bottomAnchor, constant: 12).isActive = true
        rateLowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        
        rateOpenLabel.translatesAutoresizingMaskIntoConstraints = false
        rateOpenLabel.topAnchor.constraint(equalTo: rateLowLabel.bottomAnchor, constant: 12).isActive = true
        rateOpenLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        
        rateCloseLabel.translatesAutoresizingMaskIntoConstraints = false
        rateCloseLabel.topAnchor.constraint(equalTo: rateOpenLabel.bottomAnchor, constant: 12).isActive = true
        rateCloseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        
    }
    
    func setupDetails(detail: DetailedScreenCoinData) {
        timeStartLabel.text = "Date: " + String(detail.timeOpen.prefix(10))
        timeStartLabel.textColor = .white
        rateHighLabel.text = "Rate High: " + String(detail.rateHigh)
        rateHighLabel.textColor = .white
        rateLowLabel.text = "Rate Low: " + String(detail.rateLow)
        rateLowLabel.textColor = .white
        rateOpenLabel.text = "Rate Open: " + String(detail.rateOpen)
        rateOpenLabel.textColor = .white
        rateCloseLabel.text = "Rate Close: " + String(detail.rateClose)
        rateCloseLabel.textColor = .white
        
    }
}




