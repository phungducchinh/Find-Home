//
//  TabBarViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var apitokenTab = ""
    var viewController1: PostViewController?
    var viewController2: ListViewController?
    var viewController3: HistoryViewController?
    
    var subviewController:[UIViewController] = []

    public var getApi : String?{
        didSet{
            apitokenTab = getApi!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        self.view.backgroundColor = .white
        self.delegate = self
        
        viewController1 = PostViewController()
        viewController2 = ListViewController()
        viewController3 = HistoryViewController()
        
        subviewController.append(viewController1!)
        subviewController.append(viewController2!)
        subviewController.append(viewController3!)
        
        viewController1?.tabBarItem = UITabBarItem(title: "Đăng tin", image: UIImage(named: "post-fn")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "post-fn2")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        viewController1?.tabBarItem.tag = 0
                
        viewController2?.tabBarItem = UITabBarItem(title: "Tìm trọ", image: UIImage(named: "home-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "home_icon2 new")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        viewController2?.tabBarItem.tag = 1
        
        viewController3?.tabBarItem = UITabBarItem(title: "Cá nhân", image: UIImage(named: "user-icon")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), selectedImage: UIImage(named: "user_icon new")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        viewController3?.tabBarItem.tag = 2
        
        self.apitokenTab = (viewController2?.apitoken)!
        self.setViewControllers(subviewController, animated: true)
        self.tabBar.backgroundColor = .white
        
        self.tabBar.items?[0].title = "Đăng tin"
        self.tabBar.items?[1].title = "Trang chủ"
        self.tabBar.items?[2].title = "Cá nhân"
        self.selectedIndex = 1
        self.navigationItem.title = "Tìm trọ"
        self.navigationItem.hidesBackButton = true
     
        let selectedColor   = UIColor(red: 254/255.0, green: 80/255.0, blue: 5/255.0, alpha: 1.0)
        let unselectedColor = UIColor(red: 5/255.0, green: 5/255.0, blue: 5/255.0, alpha: 1.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedColor], for: .selected)
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
        }else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "Chưa có kết nối mạng internet", message:"Vui lòng kiểm tra lại kết nối mạng", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                print("Kiểm tra kết nối internet")
            })
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func Logout(){
        print("log out")
        let vc = LoginViewController()
        MyApi.appApi = ""
        defaultsKeys.keyOne = ""
        defaultsKeys.keyTwo = ""
        vc.defaults.removeObject(forKey: defaultsKeys.keyOne)
        vc.defaults.removeObject(forKey: defaultsKeys.keyTwo)
        
        
        vc.defaApi.removeObject(forKey: "api")
        if let apiname = vc.defaApi.string(forKey: "api"){
            print("api delete " + apiname)
        }
        
        DataLogin.emailLogin = ""
        DataLogin.passLogin = ""
        print("email" + defaultsKeys.keyOne)
        print("pass" + defaultsKeys.keyTwo)
//        print("email" + DataLogin.emailLogin)
//        print("pass" + DataLogin.passLogin)
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension TabBarViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if (self.selectedViewController == viewController1)
        {
            self.navigationItem.title = "Đăng tin"
            self.navigationItem.hidesBackButton = true
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.clear], for: .normal)
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        else if (self.selectedViewController == viewController2)
        {
            viewController2?.loadApi()
            self.navigationItem.title = "Tìm trọ"
            self.navigationItem.hidesBackButton = true
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.clear], for: .normal)
        }
        else
        {
            viewController3?.loadApi()
            self.navigationItem.title = "Các tin đã đăng"
            let btn1 = UIButton(type: .custom)
            btn1.setImage(UIImage(named: "logout1-1"), for: .normal)
            btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn1.addTarget(self, action: #selector(self.Logout), for: .touchUpInside)
            let item1 = UIBarButtonItem(customView: btn1)
            self.navigationItem.setRightBarButtonItems([item1], animated: true)
           // self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"Add-icon new"), style: .plain, target: self, action: #selector(self.Logout))
        }
        
    }
    
    
}
