//
//  LoginView.swift
//  FindHome
//
//  Created by phungducchinh on 3/13/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import Foundation
import UIKit

class RegisterView: UIView {
    
    fileprivate let tbvLogin : RegisterTableView = {
        let tbvLogin = RegisterTableView()
        tbvLogin.translatesAutoresizingMaskIntoConstraints = false
        tbvLogin.layer.cornerRadius = 7
        tbvLogin.isScrollEnabled = false
        tbvLogin.contentInset = UIEdgeInsets.zero
        return tbvLogin
    }()
    
    fileprivate let btnLogin : UIButton = {
        let btnLogin = UIButton()
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.setTitle("Đăng ký", for: .normal)
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.titleLabel?.font = btnLogin.titleLabel?.font.withSize(17)
        btnLogin.layer.cornerRadius = 7
        btnLogin.backgroundColor = UIColor(red: 0/255, green: 143/255, blue: 255/255, alpha: 1)
        btnLogin.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return btnLogin
    }()
    
    fileprivate let btnFogotPass : UIButton = {
        let btnFogotPass = UIButton()
        btnFogotPass.translatesAutoresizingMaskIntoConstraints = false
        btnFogotPass.setTitle("Quên mật khẩu?", for: .normal)
        btnFogotPass.setTitleColor(.white, for: .normal)
        btnFogotPass.titleLabel?.font = btnFogotPass.titleLabel?.font.withSize(15)
        btnFogotPass.backgroundColor = nil
        return btnFogotPass
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        self.addSubview(tbvLogin)
        self.addSubview(btnLogin)
        self.addSubview(btnFogotPass)
        
        self.backgroundColor = UIColor(red: 254/255, green: 80/255, blue: 4/255, alpha: 1)
        
        self.tbvLogin.allowsSelection = false
        let views = ["tbv" : self.tbvLogin, "btnLogin" : self.btnLogin, "btnFogot" : self.btnFogotPass] as [String : Any]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[tbv(120)]-40-[btnLogin(40)]-5-[btnFogot(40)]", options: [], metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[tbv]-5-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[btnLogin]-5-|", options: [], metrics: nil, views: views))
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[btnFogot]-5-|", options: [], metrics: nil, views: views))
        
        
        let preferences = UserDefaults.standard
        
        if(preferences.object(forKey: "session") != nil)
        {
            LoginDone()
        }
        else
        {
            LoginTodo()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func signInButtonTapped() {
        
        tbvLogin.reloadData()
        
        if(tbvLogin.username == "" || tbvLogin.password == "" || tbvLogin.passwordagain == ""){
            print("error")
            var alert = UIAlertView(title: "Chưa nhập đủ thông tin", message: "Nhập đủ các thông tin trước khi đăng nhập", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }else{
            print(tbvLogin.username)
            print(tbvLogin.password)
            print(tbvLogin.passwordagain)
            
            let url = URL(string: "https://matas-app.herokuapp.com/api/v1/auth/sign_in")
            let session = URLSession.shared
            
            let request = NSMutableURLRequest(url: url!)
            request.httpMethod = "POST"
            
            let paramTosend = "email" + tbvLogin.username + "password" +  tbvLogin.password
            request.httpBody = paramTosend.data(using: String.Encoding.utf8)
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                
                guard let _:Data = data else
                {
                    return
                }
                
                let json:Any?
                
                do{
                    json = try JSONSerialization.jsonObject(with: data!, options: [])
                }
                catch
                {
                    return
                }
                
                guard let server_response = json as? NSDictionary else
                {
                    return
                }
                
                if let data_block = server_response["data"] as? NSDictionary
                {
                    if let session_data = data_block["session"] as? String
                    {
                        let preferences = UserDefaults.standard
                        preferences.set(session_data, forKey: "session")
                        
                        DispatchQueue.main.sync (
                            execute:self.LoginDone
                        )
                    }
                }
            })
            
            task.resume()
            
        }
        
    
     }
    
    func LoginDone(){
      print("Login thanh cong")
        
    }
    
    func LoginTodo(){
        print("Login khong thanh cong")
    }
        
}

