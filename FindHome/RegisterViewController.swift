//
//  LoginViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController{
    let regis = RegisterView()
    var apiRegis = ""
    var username = ""
    var password = ""
    var passwordagain = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Đăng ký"
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.backBarButtonItem?.title = "Đăng nhập"
        self.navigationItem.backBarButtonItem?.tintColor = .white
        self.navigationItem.hidesBackButton = false
        self.view = self.regis
        
        regis.btnLogin.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)

        
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
    
    func signInButtonTapped() {
        
        regis.tbvLogin.reloadData()
        
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

        let index1 = IndexPath(row: 0, section: 0)
        if let cell = regis.tbvLogin.cellForRow(at: index1) as? RegisterCell {
            regis.tbvLogin.reloadData()
            username = cell.txf.text!
        }
        
        let index2 = IndexPath(row: 1, section: 0)
        if let cell = regis.tbvLogin.cellForRow(at: index2) as? RegisterCell {
            regis.tbvLogin.reloadData()
            password = cell.txf.text!
        }
        
        let index3 = IndexPath(row: 2, section: 0)
        if let cell = regis.tbvLogin.cellForRow(at: index3) as? RegisterCell {
            regis.tbvLogin.reloadData()
            passwordagain = cell.txf.text!
        }
        
        let email = username.lowercased()
        let pass = password.lowercased()
        let repass = passwordagain.lowercased()
        
        if(email == "" || pass == "" || repass == ""){
            print("error")
            let alert = UIAlertController(title: "Chưa có nhập đủ thông tin", message:"Vui lòng nhập đầy đủ thông tin trước khi đăng ký", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                print("Chưa nhập đủ thông tin đăng ký")
            })
            self.present(alert, animated: true, completion: nil)
        }else{
            
            let url = URL(string: "https://matas-app.herokuapp.com/api/v1/auth/sign_up")
            Alamofire.request(url!, method: .post, parameters: ["email":email,"password":pass,"password_confirmation":repass], encoding: URLEncoding.httpBody).responseJSON { response in
                if let json = response.result.value as? [String: Any]
                {
                    let dicJson = json as NSDictionary
                    let stt =  (dicJson["status"] as? Bool)! //dicJson["message"] as? String
                   
                    if (stt == false ) {
                        let alert = UIAlertController(title: "Thông tin đăng ký chưa đúng", message:"Vui lòng nhập lại", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                            print("Thông tin đăng ký chưa đúng")
                        })
                        self.present(alert, animated: true, completion: nil)
                    }else
                    {
                        let name = dicJson["data"] as? [String: Any]
                        let alert = UIAlertController(title: "Chúc mừng", message:"Đăng ký thành công", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                            print("Đăng ký thành công")
                            self.apiRegis = name?["api_token"] as! String
                            let abc = ListViewController()
                            abc.apitoken = self.apiRegis
                            MyApi.appApi = self.apiRegis
                            self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                        })
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
