//
//  ViewController.swift
//  TestTabBar
//
//  Created by phungducchinh on 3/15/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let tabBarCtr = UITabBarController()
        
        let viewController1 = PostViewController()
        let viewController2 = ListViewController()
        let viewController3 = LoginViewController()
        
        
        viewController1.tabBarItem.title = "Đăng tin"
        //viewController1.view.backgroundColor = UIColor.orange
        
        
        viewController2.tabBarItem.title = "Tìm trọ"
        //viewController2.view.backgroundColor = UIColor.blue
        
        
        viewController3.tabBarItem.title = "Đăng nhâp"
        //viewController3.view.backgroundColor = UIColor.cyan
        
//        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
//        downloadsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
//        historyVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        
        viewController1.tabBarItem = UITabBarItem(title: "Đăng tin", image: UIImage(named: "post-fn")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "post-fn2")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        viewController1.tabBarItem.tag = 0
        
        viewController2.tabBarItem = UITabBarItem(title: "Tìm trọ", image: UIImage(named: "home-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "home_icon2 new")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        viewController2.tabBarItem.tag = 1
        
        viewController3.tabBarItem = UITabBarItem(title: "Cá nhân", image: UIImage(named: "user-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "user_icon new")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        viewController3.tabBarItem.tag = 2

        let controllers = [viewController1, viewController2, viewController3]
       // self.viewControllers = controllers
        
        tabBarCtr.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
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

