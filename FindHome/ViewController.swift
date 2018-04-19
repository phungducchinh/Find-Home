//
//  ViewController.swift
//  TestTabBar
//
//  Created by phungducchinh on 3/15/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    
    private let imgBg : UIImageView = {
        let imgBg = UIImageView()
        imgBg.image = UIImage(named: "Icon-1024")!
        imgBg.translatesAutoresizingMaskIntoConstraints = false
        
        return imgBg
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(self.imgBg)
        view.backgroundColor = UIColor(red: 254/255, green: 80/255, blue: 4/255, alpha: 1)
        let views = ["img" : self.imgBg]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-115-[img(90)]", options: [] , metrics: nil, views: views))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-230-[img(90)]", options: [],metrics: nil, views: views))

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            // Put your code which should be executed with a delay here
            print("please wait")
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

            let vc = LoginViewController()
            vc.navigationItem.hidesBackButton = true
            if let apiname = vc.defaApi.string(forKey: "api")
            {
                print("api default " + apiname)
                let abc = ListViewController()
                abc.apitoken = apiname
                MyApi.appApi = apiname
                print("go to tab bar" + MyApi.appApi)
                self.navigationController?.pushViewController(TabBarViewController(), animated: true)
            }else{
                print("go to login view")
                self.navigationController?.pushViewController(vc, animated: true)
            }

        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
        
    }

}

