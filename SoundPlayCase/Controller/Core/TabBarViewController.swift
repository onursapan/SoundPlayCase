//
//  TabBarViewController.swift
//  SoundPlayCase
//
//  Created by Onur Sapan on 3/4/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        
    }

}

//MARK: Navigation Bar Configuration

extension TabBarViewController {
    
    private func setupTabBar() {
        
        UITabBar.appearance().backgroundColor = .systemGray
        
        let vc1 = HomeViewController()
        vc1.viewModel = HomeViewModel.init()
        let vc2 = ResultViewController()
        let vc3 = ArtistViewController()
        let vc4 = ArtistDetailViewController()
        
        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Artist"
        vc4.title = "Artist Detail"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        vc4.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "music.note.house.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Result", image: UIImage(systemName: "magnifyingglass.circle"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Artist", image: UIImage(systemName: "music.note.list"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Detail", image: UIImage(systemName: "music.mic"), tag: 4)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1,nav2,nav3,nav4], animated: false)
    }
}

