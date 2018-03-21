//
//  ViewController.swift
//  TestTabBar
//
//  Created by phungducchinh on 3/15/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let button: UIButton = UIButton(frame: CGRect(x: view.bounds.width / 250, y: view.bounds.height / 2, width: 100, height: 50))
//        button.backgroundColor = UIColor.black
//        button.addTarget(self, action: #selector(pushToNextVC), for: .touchUpInside)
//        self.view.addSubview(button)
        
       // let tabBarController = UITabBarController()
        
        let favoritesVC = ViewController()
        favoritesVC.tabBarItem.title = "Favorites"
        favoritesVC.view.backgroundColor = UIColor.orange
        
        let downloadsVC = ViewController()
        downloadsVC.tabBarItem.title = "Downloads"
        downloadsVC.view.backgroundColor = UIColor.blue
        
        let historyVC = ViewController()
        historyVC.tabBarItem.title = "History"
        historyVC.view.backgroundColor = UIColor.cyan
        
//        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
//        downloadsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
//        historyVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        
        let controllers = [favoritesVC, downloadsVC, historyVC]
        self.viewControllers = controllers
      //  tabBarController.viewControllers = controllers
        

    }
    
//    func pushToNextVC() {
//        let newVC = UIViewController()
//        newVC.view.backgroundColor = UIColor.red
//        self.navigationController?.pushViewController(newVC, animated:
//            true)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }

}

