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

        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.backBarButtonItem?.title = "Đăng nhập"
        self.navigationItem.backBarButtonItem?.tintColor = .white
        self.navigationItem.hidesBackButton = false
        self.view = self.regis
        
        regis.btnLogin.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)

        
        //navigationController?.navigationItem.title = "Đăng ký"
        //self.navigationItem.title = "Đăng nhập"
        //self.navigationController?.navigationBar.topItem?.title = "Đăng Nhập"
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
        }else {
            print("Internet connection FAILED")
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

        
        // Do any additional setup after loading the view.
    }
    
    func signInButtonTapped() {
        
        regis.tbvLogin.reloadData()
        
        let index1 = IndexPath(row: 0, section: 0)
        if let cell = regis.tbvLogin.cellForRow(at: index1) as? RegisterCell {
            regis.tbvLogin.reloadData()
            print(cell.txf.text!)
            username = cell.txf.text!
            print("username: " + username)
        }
        
        let index2 = IndexPath(row: 1, section: 0)
        if let cell = regis.tbvLogin.cellForRow(at: index2) as? RegisterCell {
            regis.tbvLogin.reloadData()
            print(cell.txf.text!)
            password = cell.txf.text!
            print("username: " + password)
        }
        
        let index3 = IndexPath(row: 2, section: 0)
        if let cell = regis.tbvLogin.cellForRow(at: index3) as? RegisterCell {
            regis.tbvLogin.reloadData()
            print(cell.txf.text!)
            passwordagain = cell.txf.text!
            print("username: " + passwordagain)
        }
        
        let email = username.lowercased()
        let pass = password.lowercased()
        let repass = passwordagain.lowercased()
        
        if(email == "" || pass == "" || repass == ""){
            print("error")
            var alert = UIAlertView(title: "Chưa nhập đủ thông tin", message: "Nhập đủ các thông tin trước khi đăng nhập", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }else{
            print(email)
            print(pass)
            print(repass)
            
            let url = URL(string: "https://matas-app.herokuapp.com/api/v1/auth/sign_up")
            Alamofire.request(url!, method: .post, parameters: ["email":email,"password":pass,"password_confirmation":repass], encoding: URLEncoding.httpBody).responseJSON { response in
                if let json = response.result.value as? [String: Any]
                {
                    let dicJson = json as NSDictionary
                    //print(dicJson)
                    let stt =  (dicJson["status"] as? Bool)! //dicJson["message"] as? String
                    //print(stt)
                    
                    if (stt == false ) {
                        print("sai thong tin")
                        let alert = UIAlertView(title: "Thông tin đăng ký chưa đúng", message: "Vui lòng nhập lại", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    }else
                    {
                        let name = dicJson["data"] as? [String: Any]//.value(forKey:"api_token")
                        print(name?["api_token"])
                        let alert = UIAlertView(title: "Chúc mừng", message: "Đăng ký thành công", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                        self.apiRegis = name?["api_token"] as! String
                        let abc = ListViewController()
                        abc.apitoken = self.apiRegis
                        print("chinh bi dien " + abc.apitoken)
                        MyApi.appApi = self.apiRegis
                        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                    }
                }
            }
        }
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
