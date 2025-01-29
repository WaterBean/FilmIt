//
//  TabBarViewController.swift
//  FilmIt
//
//  Created by 한수빈 on 1/25/25.
//

import UIKit

final class TabBarViewController: UITabBarController {

    private let mainViewController = {
        let vc = MainViewController()
        vc.tabBarItem.image = UIImage(systemName: "popcorn")
        vc.tabBarItem.title = "CINEMA"
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    private let upcomingViewController = {
        let vc = UpcomingViewController()
        vc.tabBarItem.image = UIImage(systemName: "film.stack")
        vc.tabBarItem.title = "UPCOMING"
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    private let settingViewController = {
        let vc = SettingViewController()
        vc.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        vc.tabBarItem.title = "PROFILE"
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .point
        view.backgroundColor = .black
        setViewControllers([mainViewController, upcomingViewController, settingViewController], animated: true)
    }
    
    
}
