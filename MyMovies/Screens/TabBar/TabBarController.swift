//
//  TabBarController.swift
//  MyMovies
//
//  Created by Can Gül on 12.09.2024.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    //MARK: - Helper Functions
    private func setupUI() {
        let firstVC = createTabBar(title: "Home", image: "house", view: HomeVC())
        let secondVC = createTabBar(title: "Search", image: "magnifyingglass", view: SearchVC())
        let thirdVC = createTabBar(title: "Coming Soon", image: "hourglass", view: ComingSoonVC())
        let fourthVC = createTabBar(title: "Favorite Movies", image: "heart", view: FavoritesVC())
        
        tabBar.tintColor = .label
        setViewControllers([firstVC, secondVC, thirdVC, fourthVC], animated: true)
    }
    
    private func createTabBar(title: String, image: String, view: UIViewController) -> UINavigationController {
        let tab = UINavigationController(rootViewController: view)
        tab.tabBarItem.title = title
        tab.tabBarItem.image = UIImage(systemName: image)
        view.title = title
        return tab
    }
}
