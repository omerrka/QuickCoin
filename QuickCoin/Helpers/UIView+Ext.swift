//
//  UIView+Ext.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 11.01.2023.
//

import UIKit

extension UIView {
    
    func pin(to superView: UIView, top: UIButton) {
        
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: top.bottomAnchor, constant: 12).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}
