//
//  ViewController.swift
//  YoLoBoo
//
//  Created by Jennie Ding on 12/26/20.
//  Copyright © 2020 Juan Ding. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabBarController?.view.backgroundColor = UIColor.white
        tabBarController?.tabBar.barTintColor = UIColor.black
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let first_page = homeViewController()
        let second_page = discoveryViewController()
        let third_page = findViewController()
        let forth_page = mineViewController()
        
        let firstBarItem = UITabBarItem(title: "home", image: UIImage.init(named: "home.png"), tag: 0)
        let secondBarItem = UITabBarItem(title: "discovery", image: UIImage.init(named: "discovery.png"), tag: 0)
        let thirdBarItem = UITabBarItem(title: "find", image: UIImage.init(named: "location.png"), tag: 0)
        let forthBarItem = UITabBarItem(title: "profile", image: UIImage.init(named: "myself.png"), tag: 0)

        
        first_page.tabBarItem = firstBarItem
        second_page.tabBarItem = secondBarItem
        third_page.tabBarItem = thirdBarItem
        forth_page.tabBarItem = forthBarItem
        
        viewControllers = [first_page, second_page, third_page, forth_page]

    }
}

