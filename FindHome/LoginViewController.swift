//
//  LoginViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController{
    
    let defaults = UserDefaults.standard
    let defaApi = UserDefaults.standard
    
    
    
    let dict:[String:String] = ["email":"", "pass" : ""]
    
    let login = LoginView()
    var apiLogin = ""
    var username = ""
    var password = ""
    
    var imgname = [UIImage(named: "user")!,UIImage(named: "pass")! ]
    var holder = ["Email/Số điện thoại", "Mật khẩu" ]

    
    public let tbvLogin : LoginTableView = {
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
        
        return btnLogin
    }()
    
    fileprivate let btnRegister : UIButton = {
        let btnRegister = UIButton()
        btnRegister.translatesAutoresizingMaskIntoConstraints = false
        btnRegister.setTitle("Đăng ký", for: .normal)
        btnRegister.setTitleColor(.white, for: .normal)
        btnRegister.titleLabel?.font = btnRegister.titleLabel?.font.withSize(15)
        btnRegister.addTarget(self, action: #selector(RegisterButtonTapped), for: .touchDown)
        btnRegister.backgroundColor = nil
        return btnRegister
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogin.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        

        
        if let apiname = defaApi.string(forKey: "api")
        {
            print("api default" + apiname)
        }
        self.navigationItem.hidesBackButton = true
        self.automaticallyAdjustsScrollViewInsets = false
        print(MyApi.appApi)
        navigationItem.title = "Đăng nhập"
        
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
        tbvLogin.reloadData()
        view.addSubview(tbvLogin)
        view.addSubview(btnLogin)
        view.addSubview(btnRegister)
        
        view.backgroundColor = UIColor(red: 254/255, green: 80/255, blue: 4/255, alpha: 1)
        
        tbvLogin.dataSource = self
        tbvLogin.delegate = self
        tbvLogin.register(LoginCell.self, forCellReuseIdentifier: "Cell")

        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.tbvLogin.allowsSelection = false
        let views = ["tbv" : self.tbvLogin, "btnLogin" : self.btnLogin, "btnFogot" : self.btnRegister] as [String : Any]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[tbv(80)]-40-[btnLogin(40)]-5-[btnFogot(40)]", options: [], metrics: nil, views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[tbv]-5-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[btnLogin]-5-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-5-[btnFogot]-5-|", options: [], metrics: nil, views: views))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signInButtonTapped() {
        tbvLogin.reloadData()
        
        let index1 = IndexPath(row: 0, section: 0)
        if let cell = tbvLogin.cellForRow(at: index1) as? LoginCell {
            tbvLogin.reloadData()
            //cell.txf.text = "chinh@gmail.com"
            username = cell.txf.text!
        }
        
        let index2 = IndexPath(row: 1, section: 0)
        if let cell = tbvLogin.cellForRow(at: index2) as? LoginCell {
            tbvLogin.reloadData()
            //cell.txf.text = "12345678"
            password = cell.txf.text!
        }
        
        let email = username.lowercased()
        let pass = password.lowercased()
                
        if(email == "" || pass == ""){
            tbvLogin.reloadData()
            if(email == "" || pass == ""){
                print("error")
                let alert = UIAlertController(title: "Chưa nhập đủ thông tin", message:"Nhập đủ các thông tin trước khi đăng nhập", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                    print("nhap lai thong tin")
                })
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let url = URL(string: "https://matas-app.herokuapp.com/api/v1/auth/sign_in")
            Alamofire.request(url!, method: .post, parameters: ["email":email,"password":pass], encoding: URLEncoding.httpBody).responseJSON { response in
                if let json = response.result.value as? [String: Any]
                {
                    let dicJson = json as NSDictionary
                    let stt =  (dicJson["status"] as? Bool)! //dicJson["message"] as? String
                   
                    if (stt == false ) {
                        print("sai thong tin")

                        let alert = UIAlertController(title: "Thông tin đăng nhập chưa đúng", message:"Xin mời nhập lại", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Đã hiểu", style: .default) { action in
                            print("nhap lai thong tin")
                        })
                        self.present(alert, animated: true, completion: nil)
                    }else
                    {
                        let name = dicJson["data"] as? [String: Any]
                        let alert = UIAlertController(title: "Chúc mừng", message: "Login thành công!", preferredStyle: .alert)
                        
                        let cancel = UIAlertAction(title: "OK", style: .cancel)
                        {
                            (cancel) -> Void in
                            print("You pressed OK")
                            self.apiLogin = name?["api_token"] as! String
                            let abc = ListViewController()
                            abc.apitoken = self.apiLogin
                            MyApi.appApi = self.apiLogin
                            //default user
                            self.defaApi.set(MyApi.appApi, forKey: "api")
                            self.defaApi.synchronize()
                            //
                            self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                        }
                        alert.addAction(cancel)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    } 
    func RegisterButtonTapped() {
        print("next to view dang ky")
        let destination = RegisterViewController() // Your destination
        navigationController?.pushViewController(destination, animated: true)
    }
}

extension LoginViewController : UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tbvLogin.dequeueReusableCell(withIdentifier: "Cell") as! LoginCell
            
            cell.imaname = imgname[indexPath.row]
            cell.txfname = holder[indexPath.row]
            cell.backgroundColor = .white
            cell.txf.delegate = self
            username = cell.txf.text!
            return cell
            
        }else {
            let cell = tbvLogin.dequeueReusableCell(withIdentifier: "Cell") as! LoginCell
            
            cell.imaname = imgname[indexPath.row]
            cell.txfname = holder[indexPath.row]
            cell.backgroundColor = .white
            cell.txf.isSecureTextEntry = true
            password = cell.txf.text!
            cell.txf.delegate = self
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holder.count
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
}
