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
    var name = ""
    var phone = ""
    
    var email = ""
    var pass = ""
    var repass = ""

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
        
//        let index4 = IndexPath(row: 3, section: 0)
//        if let cell = regis.tbvLogin.cellForRow(at: index4) as? RegisterCell {
//            regis.tbvLogin.reloadData()
//            name = cell.txf.text!
//        }
//        
//        let index5 = IndexPath(row: 4, section: 0)
//        if let cell = regis.tbvLogin.cellForRow(at: index5) as? RegisterCell {
//            regis.tbvLogin.reloadData()
//            phone = cell.txf.text!
//        }
        
         email = username.lowercased()
         pass = password.lowercased()
         repass = passwordagain.lowercased()
    
        if pass.characters.count < 6 {
            print("error")
            let alert = UIAlertController(title: "Mật khẩu tối đa 6 ký tự", message:"Vui lòng nhập lại mật khẩu trước khi đăng ký", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                print("Mật khẩu chưa đúng")
            })
            self.present(alert, animated: true, completion: nil)
        }else{
            self.Register()
        }
        
    }

    func Register()  {
        if( self.email == "" || self.pass == "" || self.repass == ""){
            print("error")
            let alert = UIAlertController(title: "Chưa có nhập đủ thông tin", message:"Vui lòng nhập đầy đủ thông tin trước khi đăng ký", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                print("Chưa nhập đủ thông tin đăng ký")
            })
            self.present(alert, animated: true, completion: nil)
        }else{
            
            let url = URL(string: "https://matas-app.herokuapp.com/api/v1/auth/sign_up")
            Alamofire.request(url!, method: .post, parameters: ["email":self.email,"password":self.pass,"password_confirmation":self.repass], encoding: URLEncoding.httpBody).responseJSON { response in
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
//                            self.PutInfoUser()
//                            print(self.name)
                            self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                        })
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }

    }
    
    func PutInfoUser(){
       
        
        let abc = "https://matas-app.herokuapp.com/api/v1/user"
        
        let headers: HTTPHeaders = [
            "Http-Auth-Token": MyApi.appApi,
            "Accept": "application/json"
        ]
        
        let param = ["username" : self.name , "phone" : self.phone] as [String : Any]
        
        
        
        Alamofire.request(abc, method: HTTPMethod.put, parameters: param, headers: headers).responseJSON { response in
            if let json = response.result.value as? [String: Any]
            {
                let dict = json as NSDictionary
                let status = dict["status"] as? Bool //[String: Any]
                if status == true{
                    
                    let alert = UIAlertController(title: "Bạn đã cập nhật thành công", message:"", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                        print("Cập nhật thành công")
                    })
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    let alert = UIAlertController(title: "Cập nhật không thành công", message: "Vui lòng kiểm tra và cập nhật lại!", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Huỷ")
                    })
                    alert.addAction(ok)
                    alert.present(self, animated: true, completion: nil)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
