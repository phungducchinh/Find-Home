//
//  LoginViewController.swift
//  FindHome
//
//  Created by phungducchinh on 3/19/18.
//  Copyright © 2018 phungducchinh. All rights reserved.
//

import UIKit
import Alamofire
//import swi

class LoginViewController: UIViewController{
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

        self.automaticallyAdjustsScrollViewInsets = false
        
       // self.view = self.login
        navigationItem.title = "Đăng nhập"
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            // do some tasks..
        }else {
            print("Internet connection FAILED")
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        tbvLogin.reloadData()
        view.addSubview(tbvLogin)
        view.addSubview(btnLogin)
        view.addSubview(btnRegister)
        
        view.backgroundColor = UIColor(red: 254/255, green: 80/255, blue: 4/255, alpha: 1)
        
        tbvLogin.dataSource = self
        tbvLogin.delegate = self
        tbvLogin.register(LoginCell.self, forCellReuseIdentifier: "Cell")

        
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
            print(cell.txf.text!)
            username = cell.txf.text!
            print("username: " + username)
        }
        
        let index2 = IndexPath(row: 1, section: 0)
        if let cell = tbvLogin.cellForRow(at: index2) as? LoginCell {
            tbvLogin.reloadData()
            print(cell.txf.text!)
            password = cell.txf.text!
            print("username: " + username)
        }
        
        let email = username.lowercased()
        let pass = password.lowercased()
        
        
        
        if(email == "" || pass == ""){
            tbvLogin.reloadData()
            if(email == "" || pass == ""){
                print("error")
                var alert = UIAlertView(title: "Chưa nhập đủ thông tin", message: "Nhập đủ các thông tin trước khi đăng nhập", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        }else{
            print(email)
            print(pass)
            
            let url = URL(string: "https://matas-app.herokuapp.com/api/v1/auth/sign_in")
            Alamofire.request(url!, method: .post, parameters: ["email":email,"password":pass], encoding: URLEncoding.httpBody).responseJSON { response in
                if let json = response.result.value as? [String: Any]
                {
                    let dicJson = json as NSDictionary
                    //print(dicJson)
                    let stt =  (dicJson["status"] as? Bool)! //dicJson["message"] as? String
                    //print(stt)
                    
                    if (stt == false ) {
                        print("sai thong tin")
                        let alert = UIAlertView(title: "Thông tin đăng nhập chưa đúng", message: "Vui lòng nhập lại", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    }else
                    {
                        let name = dicJson["data"] as? [String: Any]//.value(forKey:"api_token")
                        print(name?["api_token"])
                        let alert = UIAlertView(title: "Chúc mừng", message: "Login thành công", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                        self.apiLogin = name?["api_token"] as! String
                        let abc = ListViewController()
                        abc.apitoken = self.apiLogin
                        print("chinh bi dien " + abc.apitoken)
                        MyApi.appApi = self.apiLogin
                        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
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
    
    func LoginDone(){
        print("Login thanh cong")
        
    }
    
    func LoginTodo(){
        print("Login khong thanh cong")
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

extension LoginViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tbvLogin.dequeueReusableCell(withIdentifier: "Cell") as! LoginCell
            
            cell.imaname = imgname[indexPath.row]
            cell.txfname = holder[indexPath.row]
            cell.backgroundColor = .white
            
            username = cell.txf.text!
            return cell
            
        }else {
            let cell = tbvLogin.dequeueReusableCell(withIdentifier: "Cell") as! LoginCell
            
            cell.imaname = imgname[indexPath.row]
            cell.txfname = holder[indexPath.row]
            cell.backgroundColor = .white
            
            password = cell.txf.text!
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    //    override func numberOfRows(inSection section: Int) -> Int {
    //        return 1    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return holder.count
    }
    
}
