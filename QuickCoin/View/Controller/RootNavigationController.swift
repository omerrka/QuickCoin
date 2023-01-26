//
//  RootNavigationController.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 19.01.2023.
//

import UIKit

class RootNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    private func setupAppearance() {

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0), .foregroundColor: UIColor.label]
        appearance.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)

        navigationBar.tintColor = .label
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance

    }
}
