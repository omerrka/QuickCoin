//
//  MainTabBarVC.swift
//  QuickCoin
//
//  Created by Aybike Zeynep Tiryaki on 28.12.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = RootNavigationController(rootViewController: HomeScreenVC())
        let vc2 = RootNavigationController(rootViewController: SearchScreenVC())
        let vc3 = RootNavigationController(rootViewController: DetailedScreenVC())

        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        vc3.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait.fill")
        
        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Detailed"
        setViewControllers([vc1, vc2, vc3], animated: true)
        
    }
}

