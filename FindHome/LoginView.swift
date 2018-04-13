//
//  LoginView.swift
//  FindHome
//
//  Created by phungducchinh on 3/13/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    fileprivate let tbvLogin : LoginTableView = {
        let tbvLogin = LoginTableView()
        tbvLogin.translatesAutoresizingMaskIntoConstraints = false
        tbvLogin.layer.cornerRadius = 7
        tbvLogin.isScrollEnabled = false
        tbvLogin.contentInset = UIEdgeInsets.zero
        return tbvLogin
    }()
    
    fileprivate let btnLogin : UIButton = {
        let btnLogin = UIButton()
        btnLogin.translatesAutoresizingMaskIntoConstraints = false
        btnLogin.setTitle("Đăng nhập", for: .normal)
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.titleLabel?.font = btnLogin.titleLabel?.font.withSize(17)
        btnLogin.layer.cornerRadius = 7
        btnLogin.backgroundColor = UIColor(red: 0/255, green: 143/255, blue: 255/255, alpha: 1)
        btnLogin.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return btnLogin
    }()
    
    fileprivate let btnRegister : UIButton = {
        let btnRegister = UIButton()
        btnRegister.translatesAutoresizingMaskIntoConstraints = false
        btnRegister.setTitle("Đăng ký", for: .normal)
        btnRegister.setTitleColor(.white, for: .normal)
        btnRegister.titleLabel?.font = btnRegister.titleLabel?.font.withSize(15)
        btnRegister.addTarget(self, action: #selector(RegisterButtonTapped), for: .touchUpInside)
        btnRegister.backgroundColor = nil
        return btnRegister
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        self.addSubview(tbvLogin)
        self.addSubview(btnLogin)
        self.addSubview(btnRegister)
        
        self.backgroundColor = UIColor(red: 254/255, green: 80/255, blue: 4/255, alpha: 1)
        
        self.tbvLogin.allowsSelection = false
        let views = ["tbv" : self.tbvLogin, "btnLogin" : self.btnLogin, "btnFogot" : self.btnRegister] as [String : Any]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[tbv(80)]-40-[btnLogin(40)]-5-[btnFogot(40)]", options: [], metrics: nil, views: views))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[tbv]-5-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[btnLogin]-5-|", options: [], metrics: nil, views: views))
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[btnFogot]-5-|", options: [], metrics: nil, views: views))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func signInButtonTapped() {
        
        tbvLogin.reloadData()
        
     }
    func RegisterButtonTapped() {
    }
        
}

