//
//  TabBar.swift
//  FinalPj-Tornike Eristavi
//
//  Created by Tornike Eristavi on 01.07.24.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favouritesVC = FavouritesViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        homeVC.tabBarItem.selectedImage = UIImage(systemName: "house.fill")?.withTintColor(UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0), renderingMode: .alwaysOriginal)
        homeVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)], for: .selected)
       
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        searchVC.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0), renderingMode: .alwaysOriginal)
        searchVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)], for: .selected)
        
        favouritesVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "bookmark.fill"), tag: 2)
        favouritesVC.tabBarItem.selectedImage = UIImage(systemName: "bookmark.fill")?.withTintColor(UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0), renderingMode: .alwaysOriginal)
        favouritesVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1.0)], for: .selected)
        
        let viewControllerList = [homeVC, searchVC, favouritesVC]
        
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
        
        
        tabBar.barTintColor = UIColor(hex: "#161616")
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }
}



