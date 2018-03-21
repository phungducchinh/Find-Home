//
//  TabBarViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    
    var viewController1: PostViewController?
    var viewController2: ListViewController?
    var viewController3: LoginViewController?
    
    var subviewController:[UIViewController] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        self.view.backgroundColor = .white
        
        viewController1 = PostViewController()
        viewController2 = ListViewController()
        viewController3 = LoginViewController()
        
        subviewController.append(viewController1!)
        subviewController.append(viewController2!)
        subviewController.append(viewController3!)
        
        viewController1?.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_user")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "icon_user")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        viewController1?.tabBarItem.tag = 0
        
        viewController2?.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_user")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "icon_user")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        viewController2?.tabBarItem.tag = 1
        
        viewController3?.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icon_user")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "icon_user")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        viewController3?.tabBarItem.tag = 2
        
        self.setViewControllers(subviewController, animated: true)
        
        self.tabBar.items?[0].title = "Đăng tin"
        self.tabBar.items?[1].title = "Trang chủ"
        self.tabBar.items?[2].title = "Đăng nhập"
        self.selectedIndex = 0
        self.selectedViewController = viewController1
        
        let selectedColor   = UIColor(red: 254/255.0, green: 80/255.0, blue: 5/255.0, alpha: 1.0)
        let unselectedColor = UIColor(red: 5/255.0, green: 5/255.0, blue: 5/255.0, alpha: 1.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedColor], for: .selected)

        switch self.selectedIndex {
            case 0:
            navigationItem.title = "Đăng tin"
            case 1:
            navigationItem.title = "Tìm trọ"
            case 2:
            navigationItem.title = "Đăng tin"
            default:
            navigationItem.title = "Tìm trọ"
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
